# seed_parking.py
from app import app, db, ParkingLot, ParkingSlot

def seed_parking():
    with app.app_context():
        # Example parking lots
        lots = [
            {"name": "Main Campus Lot", "total_bike_slots": 100, "total_car_slots": 50},
            {"name": "North Gate Lot", "total_bike_slots": 80, "total_car_slots": 40},
            {"name": "Library Lot", "total_bike_slots": 60, "total_car_slots": 30},
        ]

        for lot_data in lots:
            lot = ParkingLot.query.filter_by(name=lot_data["name"]).first()
            if not lot:
                lot = ParkingLot(**lot_data)
                db.session.add(lot)
                db.session.commit()
            # Add slots for this lot
            existing_slots = ParkingSlot.query.filter_by(lot_id=lot.id).count()
            if existing_slots == 0:
                # Add bike slots
                for i in range(lot.total_bike_slots):
                    slot = ParkingSlot(lot_id=lot.id, slot_type="Bike", status="Vacant")
                    db.session.add(slot)
                # Add car slots
                for i in range(lot.total_car_slots):
                    slot = ParkingSlot(lot_id=lot.id, slot_type="Car", status="Vacant")
                    db.session.add(slot)
                db.session.commit()
        print("Parking lots and slots seeded successfully.")

if __name__ == "__main__":
    seed_parking()