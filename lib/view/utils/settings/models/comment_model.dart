
class HostComment {
  String message;
  String user;
  String image;
  String age;
  String country;
  String id;

  HostComment(
      {required this.message,
      required this.user,
      required this.image,
      required this.age,
      required this.country,
      required this.id});
}
class HostComment1 {
  String message;
  String user;
  String image;

  HostComment1(
      {required this.message, required this.user, required this.image});
}
List<HostComment> hostCommentList = [];

List<HostComment> demoStreamList = [];
List<HostComment1> demoStreamList1 = [];
List<String> commentUser = [
  "https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=688&q=80",
  "https://images.unsplash.com/photo-1552058544-f2b08422138a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=699&q=80",
  "https://images.unsplash.com/photo-1554151228-14d9def656e4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=686&q=80",
  "https://images.unsplash.com/photo-1500048993953-d23a436266cf?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1169&q=80",
  "https://images.unsplash.com/photo-1599566150163-29194dcaad36?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
  "https://images.unsplash.com/photo-1496302662116-35cc4f36df92?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
  "https://images.unsplash.com/photo-1500259783852-0ca9ce8a64dc?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80",
  "https://images.unsplash.com/photo-1580489944761-15a19d654956?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=761&q=80",
  "https://images.unsplash.com/photo-1555952517-2e8e729e0b44?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80",
  "https://images.unsplash.com/photo-1542206395-9feb3edaa68d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80"
];
List<String> usrLevel = [
  "Edward Baily",
  "Thomas ",
  "Lily Adams",
  "lsabella kennedy",
  "Charlotte Beiley",
  "Dainel Marshall",
  "Bailey Mia",
  "Isabella",
];
List<HostComment1> hostCommentList1 = [
  HostComment1(
      message: "How are You?", user: usrLevel[0], image: commentUser[0]),
  HostComment1(
    message: "Hello Dear",
    user: usrLevel[0],
    image: commentUser[1],
  ),
  HostComment1(
      message: "9876543210 it is my mobile number",
      user: usrLevel[1],
      image: commentUser[2]),
  HostComment1(
      message: "Your Hotness is beating me everytime?",
      user: usrLevel[2],
      image: commentUser[3]),
  HostComment1(
      message: "i drop my cap for you?",
      user: usrLevel[3],
      image: commentUser[4]),
  HostComment1(
      message: "classy shot and awesome background too",
      user: usrLevel[4],
      image: commentUser[5]),
  HostComment1(
      message: "give me your mobile number",
      user: usrLevel[5],
      image: commentUser[6]),
  HostComment1(
      message: "can we talk?", user: usrLevel[2], image: commentUser[7]),
  HostComment1(
      message: "looking very very hot",
      user: usrLevel[6],
      image: commentUser[8]),
  HostComment1(
      message: "let's hangout", user: usrLevel[4], image: commentUser[9]),
  HostComment1(message: "Joined", user: usrLevel[0], image: commentUser[0]),
  HostComment1(
    message: "Hello Dear",
    user: usrLevel[0],
    image: commentUser[1],
  ),
  HostComment1(
      message: "9876543210 it is my mobile number",
      user: usrLevel[1],
      image: commentUser[2]),
  HostComment1(
      message: "Your Hotness is beating me everytime?",
      user: usrLevel[2],
      image: commentUser[3]),
  HostComment1(
      message: "i drop my cap for you?",
      user: usrLevel[3],
      image: commentUser[4]),
  HostComment1(
      message: "classy shot and awesome background too",
      user: usrLevel[4],
      image: commentUser[5]),
  HostComment1(
      message: "give me your mobile number",
      user: usrLevel[5],
      image: commentUser[6]),
  HostComment1(message: "Joined", user: usrLevel[7], image: commentUser[6]),
  HostComment1(
      message: "can we talk?", user: usrLevel[1], image: commentUser[7]),
  HostComment1(
      message: "looking very very hot",
      user: usrLevel[6],
      image: commentUser[8]),
  HostComment1(
      message: "let's hangout", user: usrLevel[3], image: commentUser[9]),
  HostComment1(
      message: "How are You?", user: usrLevel[4], image: commentUser[0]),
  HostComment1(message: "Hello Dear", user: usrLevel[0], image: commentUser[1]),
  HostComment1(
      message: "9876543210 it is my mobile number",
      user: usrLevel[7],
      image: commentUser[2]),
  HostComment1(message: "Joined", user: usrLevel[0], image: commentUser[3]),
  HostComment1(
      message: "i drop my cap for you?",
      user: usrLevel[1],
      image: commentUser[4]),
  HostComment1(
      message: "classy shot and awesome background too",
      user: usrLevel[2],
      image: commentUser[5]),
  HostComment1(
      message: "give me your mobile number",
      user: usrLevel[3],
      image: commentUser[6]),
  HostComment1(
      message: "can we talk?", user: usrLevel[1], image: commentUser[7]),
  HostComment1(
      message: "looking very very hot",
      user: usrLevel[4],
      image: commentUser[8]),
  HostComment1(
      message: "let's hangout", user: usrLevel[3], image: commentUser[9]),
  HostComment1(
      message: "How are You?", user: usrLevel[4], image: commentUser[0]),
  HostComment1(message: "Hello Dear", user: usrLevel[0], image: commentUser[1]),
  HostComment1(
      message: "9876543210 it is my mobile number",
      user: usrLevel[5],
      image: commentUser[2]),
  HostComment1(
      message: "Your Hotness is beating me everytime?",
      user: usrLevel[6],
      image: commentUser[3]),
  HostComment1(message: "Joined", user: usrLevel[0], image: commentUser[1]),
  HostComment1(
      message: "i drop my cap for you?",
      user: usrLevel[7],
      image: commentUser[4]),
  HostComment1(
      message: "classy shot and awesome background too",
      user: usrLevel[0],
      image: commentUser[5]),
  HostComment1(
      message: "give me your mobile number",
      user: usrLevel[1],
      image: commentUser[6]),
  HostComment1(
      message: "can we talk?", user: usrLevel[1], image: commentUser[7]),
  HostComment1(
      message: "looking very very hot",
      user: usrLevel[2],
      image: commentUser[8]),
  HostComment1(
      message: "let's hangout", user: usrLevel[3], image: commentUser[9]),
  HostComment1(message: "Joined", user: usrLevel[4], image: commentUser[0]),
  HostComment1(message: "Hello Dear", user: usrLevel[0], image: commentUser[1]),
  HostComment1(
      message: "9876543210 it is my mobile number",
      user: usrLevel[3],
      image: commentUser[2]),
  HostComment1(
      message: "Your Hotness is beating me everytime?",
      user: usrLevel[4],
      image: commentUser[3]),
  HostComment1(
      message: "i drop my cap for you?",
      user: usrLevel[5],
      image: commentUser[4]),
  HostComment1(
      message: "classy shot and awesome background too",
      user: usrLevel[6],
      image: commentUser[5]),
  HostComment1(message: "Joined", user: usrLevel[3], image: commentUser[9]),
  HostComment1(
      message: "give me your mobile number",
      user: usrLevel[7],
      image: commentUser[6]),
  HostComment1(
      message: "can we talk?", user: usrLevel[1], image: commentUser[7]),
  HostComment1(
      message: "looking very very hot",
      user: usrLevel[0],
      image: commentUser[8]),
  HostComment1(message: "Joined", user: usrLevel[3], image: commentUser[9]),
  HostComment1(
      message: "How are You?", user: usrLevel[4], image: commentUser[0]),
  HostComment1(message: "Hello Dear", user: usrLevel[0], image: commentUser[1]),
  HostComment1(
      message: "9876543210 it is my mobile number",
      user: usrLevel[1],
      image: commentUser[2]),
  HostComment1(
      message: "Your Hotness is beating me everytime?",
      user: usrLevel[2],
      image: commentUser[3]),
  HostComment1(
      message: "i drop my cap for you?",
      user: usrLevel[3],
      image: commentUser[4]),
  HostComment1(
      message: "classy shot and awesome background too",
      user: usrLevel[4],
      image: commentUser[5]),
  HostComment1(
      message: "give me your mobile number",
      user: usrLevel[5],
      image: commentUser[6]),
  HostComment1(message: "Joined", user: usrLevel[1], image: commentUser[7]),
  HostComment1(
      message: "looking very very hot",
      user: usrLevel[6],
      image: commentUser[8]),
  HostComment1(
      message: "let's hangout", user: usrLevel[7], image: commentUser[9]),
];