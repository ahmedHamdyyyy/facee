
abstract class SocialLginStutes{}
class SocialLoginInitialStates extends SocialLginStutes{}
class SocialLoginlodingStates extends SocialLginStutes{}
class SocialLoginSuccessStates extends SocialLginStutes{
  final String uId;

  SocialLoginSuccessStates(this.uId);

}
class SocialLoginErrorStates extends SocialLginStutes
{
  final String error;
  SocialLoginErrorStates(this.error);
}
class SocialchangedPasswordStates extends SocialLginStutes{}
class ChangeIconeStute extends SocialLginStutes{}
class SocialCreateSuccessStatess extends SocialLginStutes{}
class SocialCreateErrorStatess extends SocialLginStutes{}


