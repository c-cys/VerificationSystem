from ultralytics import YOLO

def run():
    model = YOLO('best.pt')

    file_name = 'test250805.jpg' # file_name = "https://imgbb.com/???"
    result = model(file_name)

    result_name = f'detection/result_{file_name}'
    result[0].save(filename=result_name)

    detections = []
    for box in result[0].boxes:
        detections.append({
            'class_id': int(box.cls[0]),
            'confidence': float(box.conf[0]),
            'bbox': [round(x, 1) for x in box.xyxy[0].tolist()]
        })

    return detections, result_name