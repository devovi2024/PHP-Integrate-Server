<?php
// Include the database connection
include 'db.php';

// Handle the request to add a new appointment
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $patient_id = $_POST['patient_id'];
    $doctor_id = $_POST['doctor_id'];
    $appoin_info = $_POST['appoin_info'];
    $appoin_date = $_POST['appoin_date'];

    // Insert the new appointment into the database
    $query = $conn->prepare("INSERT INTO Appointment (patient_id, doctor_id, appoin_info, appoin_date) 
                             VALUES (:patient_id, :doctor_id, :appoin_info, :appoin_date)");
    $query->bindParam(':patient_id', $patient_id);
    $query->bindParam(':doctor_id', $doctor_id);
    $query->bindParam(':appoin_info', $appoin_info);
    $query->bindParam(':appoin_date', $appoin_date);

    if ($query->execute()) {
        echo "Appointment added successfully!";
    } else {
        echo "Failed to add appointment.";
    }
}




// Fetch all appointments from the database
$query = $conn->prepare("SELECT Appointment.appoin_id, Patient.name AS patient_name, Doctor.name AS doctor_name, 
                         Appointment.appoin_info, Appointment.appoin_date 
                         FROM Appointment 
                         INNER JOIN Patient ON Appointment.patient_id = Patient.patient_id 
                         INNER JOIN Doctor ON Appointment.doctor_id = Doctor.doctor_id");
$query->execute();

// Fetch the appointments as an associative array
$appointments = $query->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Appointment Management</title>
</head>
<body>
    <h1>Appointments</h1>

    <!-- Form to create a new appointment -->
    <h2>Book a New Appointment</h2>
    <form action="appointment.php" method="POST">
        <label for="patient_id">Patient ID:</label>
        <input type="text" name="patient_id" required><br><br>
        
        <label for="doctor_id">Doctor ID:</label>
        <input type="text" name="doctor_id" required><br><br>
        
        <label for="appoin_info">Appointment Info:</label>
        <textarea name="appoin_info" required></textarea><br><br>


        
        <label for="appoin_date">Appointment Date:</label>
        <input type="date" name="appoin_date" required><br><br>
        
        <button type="submit">Book Appointment</button>
    </form>

    <h2>Existing Appointments</h2>
    <table border="1">
        <thead>
            <tr>
                <th>Appointment ID</th>
                <th>Patient Name</th>
                <th>Doctor Name</th>
                <th>Appointment Info</th>
                <th>Appointment Date</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($appointments as $appointment): ?>
                <tr>
                    <td><?php echo $appointment['appoin_id']; ?></td>
                    <td><?php echo $appointment['patient_name']; ?></td>
                    <td><?php echo $appointment['doctor_name']; ?></td>
                    <td><?php echo $appointment['appoin_info']; ?></td>
                    <td><?php echo $appointment['appoin_date']; ?></td>
                </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
</body>
</html>
