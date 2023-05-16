const project = {
    members: [
      { member: "1", status: "pending" },
      { member: "2", status: "accept" },
      { member: "3", status: "pending" },
    ],
  };
  
  const memberId = "2";
  
  // Find the member in the array
  const member = project.members.find(
    (member) => member.member === memberId
  );
  
  if (!member) {
    console.log("Member not found");
  } else {
    // Change the member's status to "leaving"
    member.status = "leaving";
    console.log("Member status changed to leaving");
  
    // Log the updated project
    console.log(project);
  }


  console.log('\x1b[32m' , "test --------------------------------------------------------------------------");