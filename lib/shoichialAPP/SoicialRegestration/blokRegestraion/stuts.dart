
abstract class SocialRegestStutes{}
class SocialRegestInitialStates extends SocialRegestStutes{}


class SocialRegestlodingStates extends SocialRegestStutes{}
class SocialRegestSuccessStates extends SocialRegestStutes{
}
class SocialRegestErrorStates extends SocialRegestStutes
{
  final String error;
  SocialRegestErrorStates(this.error);
}




class SocialCreatelodingStates extends SocialRegestStutes{}
class SocialCreateSuccessStates extends SocialRegestStutes{
}
class SocialCreateErrorStates extends SocialRegestStutes
{
  final String error;
  SocialCreateErrorStates(this.error);
}



class SocialchangedPasswordStatesREGES extends SocialRegestStutes{}
