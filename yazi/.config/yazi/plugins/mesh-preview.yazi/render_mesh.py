#!/usr/bin/env python3
"""
Render 3D mesh/point cloud files to PNG images for yazi preview.
Usage: render_mesh.py <input_file> <output_file> [width] [height]
"""

import sys
import os

os.environ.setdefault("PYOPENGL_PLATFORM", "egl")


def render_with_pyrender(mesh_trimesh, output_path, width, height):
    import numpy as np
    import pyrender
    from PIL import Image

    scene = pyrender.Scene(
        bg_color=[0.118, 0.118, 0.180, 1.0],
        ambient_light=[0.4, 0.4, 0.4],
    )

    pm = pyrender.Mesh.from_trimesh(mesh_trimesh, smooth=False)
    scene.add(pm)

    # Center and frame the camera
    centroid = mesh_trimesh.centroid
    extents = mesh_trimesh.extents
    extent = float(np.max(extents))

    # Isometric-ish view: 30° elevation, 45° azimuth
    elev = np.radians(30)
    azim = np.radians(45)
    dist = extent * 2.0

    cam_x = centroid[0] + dist * np.cos(elev) * np.sin(azim)
    cam_y = centroid[1] - dist * np.cos(elev) * np.cos(azim)
    cam_z = centroid[2] + dist * np.sin(elev)

    # Build look-at matrix
    forward = np.array([centroid[0] - cam_x, centroid[1] - cam_y, centroid[2] - cam_z])
    forward /= np.linalg.norm(forward)
    up = np.array([0.0, 0.0, 1.0])
    right = np.cross(forward, up)
    if np.linalg.norm(right) < 1e-6:
        up = np.array([0.0, 1.0, 0.0])
        right = np.cross(forward, up)
    right /= np.linalg.norm(right)
    up = np.cross(right, forward)

    cam_pose = np.eye(4)
    cam_pose[:3, 0] = right
    cam_pose[:3, 1] = up
    cam_pose[:3, 2] = -forward
    cam_pose[:3, 3] = [cam_x, cam_y, cam_z]

    fov = np.pi / 4
    camera = pyrender.PerspectiveCamera(yfov=fov, aspectRatio=width / height)
    scene.add(camera, pose=cam_pose)

    # Key + fill lights
    key_light = pyrender.DirectionalLight(color=[1.0, 1.0, 1.0], intensity=4.0)
    scene.add(key_light, pose=cam_pose)

    fill_pose = np.eye(4)
    fill_pose[:3, 3] = [centroid[0] - dist, centroid[1] + dist, centroid[2] + dist * 0.5]
    fill_pose[:3, 2] = -forward
    fill_light = pyrender.DirectionalLight(color=[0.8, 0.9, 1.0], intensity=2.0)
    scene.add(fill_light, pose=fill_pose)

    r = pyrender.OffscreenRenderer(width, height)
    color, _ = r.render(scene)
    r.delete()
    Image.fromarray(color).save(output_path, format="PNG")


def render_point_cloud_matplotlib(points, colors, output_path, width, height):
    import numpy as np
    import matplotlib
    matplotlib.use("Agg")
    import matplotlib.pyplot as plt

    MAX_POINTS = 100000
    if len(points) > MAX_POINTS:
        idx = np.random.choice(len(points), MAX_POINTS, replace=False)
        points = points[idx]
        if colors is not None:
            colors = colors[idx]

    centroid = points.mean(axis=0)
    points = points - centroid
    scale = np.abs(points).max()
    if scale > 0:
        points = points / scale * 0.85

    fig = plt.figure(figsize=(width / 100, height / 100), dpi=100)
    fig.patch.set_facecolor("#1e1e2e")
    ax = fig.add_subplot(111, projection="3d")
    ax.set_facecolor("#1e1e2e")

    if colors is not None and len(colors) == len(points):
        pt_colors = colors / 255.0 if colors.max() > 1 else colors
    else:
        z = points[:, 2]
        z_norm = (z - z.min()) / (z.max() - z.min() + 1e-8)
        pt_colors = plt.cm.plasma(z_norm * 0.6 + 0.2)

    ax.scatter(points[:, 0], points[:, 1], points[:, 2], c=pt_colors, s=1, alpha=0.8)
    ax.set_xlim(-1, 1); ax.set_ylim(-1, 1); ax.set_zlim(-1, 1)
    ax.view_init(elev=20, azim=45)
    ax.set_axis_off()
    ax.set_box_aspect([1, 1, 1])
    plt.tight_layout(pad=0)
    plt.subplots_adjust(left=0, right=1, top=1, bottom=0)
    plt.savefig(output_path, format="png", facecolor=fig.get_facecolor(),
                bbox_inches="tight", pad_inches=0.05, dpi=100)
    plt.close(fig)


def load_and_render(input_path, output_path, width, height):
    import trimesh
    import numpy as np

    data = trimesh.load(input_path)

    if isinstance(data, trimesh.PointCloud):
        points = np.array(data.vertices)
        colors = np.array(data.colors)[:, :3] if hasattr(data, "colors") and data.colors is not None and len(data.colors) > 0 else None
        render_point_cloud_matplotlib(points, colors, output_path, width, height)

    elif isinstance(data, trimesh.Scene):
        meshes = [g for g in data.geometry.values() if isinstance(g, trimesh.Trimesh)]
        clouds = [np.array(g.vertices) for g in data.geometry.values() if isinstance(g, trimesh.PointCloud)]
        if meshes:
            mesh = trimesh.util.concatenate(meshes)
            render_with_pyrender(mesh, output_path, width, height)
        elif clouds:
            render_point_cloud_matplotlib(np.vstack(clouds), None, output_path, width, height)
        else:
            raise ValueError("No renderable geometry found in scene")

    elif isinstance(data, trimesh.Trimesh):
        render_with_pyrender(data, output_path, width, height)

    else:
        raise ValueError(f"Unsupported geometry type: {type(data)}")


def main():
    if len(sys.argv) < 3:
        print(f"Usage: {sys.argv[0]} <input_file> <output_file> [width] [height]", file=sys.stderr)
        sys.exit(1)

    from urllib.parse import urlparse, unquote
    input_path = sys.argv[1]
    if input_path.startswith("file://"):
        input_path = unquote(urlparse(input_path).path)
    output_path = sys.argv[2]
    width = int(sys.argv[3]) if len(sys.argv) > 3 else 800
    height = int(sys.argv[4]) if len(sys.argv) > 4 else 600

    if not os.path.exists(input_path):
        print(f"Error: Input file not found: {input_path}", file=sys.stderr)
        sys.exit(1)

    try:
        load_and_render(input_path, output_path, width, height)
        print(f"Rendered: {output_path}")
        sys.exit(0)
    except Exception as e:
        import traceback
        msg = traceback.format_exc()
        print(f"Error rendering mesh: {e}", file=sys.stderr)
        with open("/tmp/mesh_preview_error.log", "w") as f:
            f.write(msg)
        sys.exit(1)


if __name__ == "__main__":
    main()
