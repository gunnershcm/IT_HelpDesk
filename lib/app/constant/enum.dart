import 'package:flutter/material.dart';

enum TicketStatus {
  open("Open"),
  assigned("Assigned"),
  inProgress("In Progress"),
  resolved("Resolved"),
  closed("Closed"),
  cancelled("Cancelled");

  final String value;
  const TicketStatus(this.value);
}

String getNameTicketStatus(int status) {
  switch (status) {
    case 0:
      return "Open";
    case 1:
      return "Assigned";
    case 2:
      return "In Progress";
    case 3:
      return "Resolved";
    case 4:
      return "Closed";
    case 5:
      return "Cancelled";
    default:
      return "Not Assigned";
  }
}

enum Priority {
  low("Low"),
  medium("Medium"),
  high("High"),
  critical("Critical"),
  ;

  final String value;
  const Priority(this.value);
}

int valueFromPriority(Priority status) {
  switch (status) {
    case Priority.low:
      return 0;
    case Priority.medium:
      return 1;
    case Priority.high:
      return 2;
    case Priority.critical:
      return 3;
    default:
      return 0;
  }
}

int valueFromPriorityName(String status) {
  if (status == Priority.low.value) {
    return 0;
  }
  if (status == Priority.medium.value) {
    return 1;
  }
  if (status == Priority.high.value) {
    return 2;
  }
  if (status == Priority.critical.value) {
    return 3;
  }
  return 0;
}

String nameFromPriority(int status) {
  switch (status) {
    case 0:
      return "Low";
    case 1:
      return "Medium";
    case 2:
      return "High";
    case 3:
      return "Critical";
    default:
      return "Not Assigned";
  }
}

enum Role { admin, customer, manager, technician, accountant }

String nameRole(int role) {
  switch (role) {
    case 0:
      return "Admin";
    case 1:
      return "Customer";
    case 2:
      return "Manager";
    case 3:
      return "Technician";
    case 4:
      return "Accountant";
    default:
      return "Not Assigned";
  }
}

enum Gender { male, female, other, preferNotToSay }

String nameGender(int role) {
  switch (role) {
    case 0:
      return "Male";
    case 1:
      return "Female";
    case 2:
      return "Other";
    case 3:
      return "Prefer Not To Say";
    default:
      return "Not Assigned";
  }
}

String nameTaskStatus(int status) {
  switch (status) {
    case 0:
      return "New";
    case 1:
      return "InProgress";
    case 2:
      return "Completed";
    case 3:
      return "Cancelled";
    default:
      return "Not Assigned";
  }
}


Map<int, String> taskStatus = {
  0: "New",
  1: "InProgress",
  2: "Completed",
  3: "Cancelled",
};

Color colorTaskStatus(int status) {
  switch (status) {
    case 0:
      return Colors.grey;
    case 1:
      return Colors.blue;
    case 2:
      return Colors.green;
    case 3:
      return Colors.red;
    default:
      return Colors.black;
  }
}

String nameImpact(int impact) {
  switch (impact) {
    case 0:
      return "Low";
    case 1:
      return "Medium";
    case 2:
      return "High";
    default:
      return "Not Assigned";
  }
}

String nameUrgency(int urgency) {
  switch (urgency) {
    case 0:
      return "Low";
    case 1:
      return "Medium";
    case 2:
      return "High";
    case 3:
      return "Urgent";
    default:
      return "Not Assigned";
  }
}

String getApproveStatus(bool? status) {
  switch (status) {
    case true:
      return "Approved"; //
    case false:
      return "Not Approved";
    default:
      return "";
  }
}

String getPublicStatus(bool? status) {
  switch (status) {
    case true:
      return "Public"; //
    case false:
      return "Private";
    default:
      return "Not Assigned";
  }
}

bool isLike(int? value) {
  switch (value) {
    case 0:
      return true;
    case 1:
      return false;
    case null:
      return false;
    default:
      return false;
  }
}

bool isDislike(int? value) {
  switch (value) {
    case 0:
      return false;
    case 1:
      return true;
    case null:
      return false;
    default:
      return false;
  }
}
