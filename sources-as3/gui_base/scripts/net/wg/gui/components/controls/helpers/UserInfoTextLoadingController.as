package net.wg.gui.components.controls.helpers
{
   import flash.events.EventDispatcher;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.events.UserInfoTextEvent;
   import net.wg.infrastructure.interfaces.IUserProps;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   [Event(name="userRatingChanged",type="net.wg.gui.components.controls.events.UserInfoTextEvent")]
   [Event(name="userNameChanged",type="net.wg.gui.components.controls.events.UserInfoTextEvent")]
   public class UserInfoTextLoadingController extends EventDispatcher implements IDisposable
   {
      
      public static const EMPTY_USER_RATING:String = "-1";
      
      public static const EMPTY_USER_NAME:String = "";
       
      
      private var _userName:UserNameTextFieldLoadingContainer;
      
      private var _userRating:TextFieldLoadingContainer;
      
      private var _disposed:Boolean = false;
      
      public function UserInfoTextLoadingController()
      {
         super();
         this._userName = new UserNameTextFieldLoadingContainer();
         this._userRating = new TextFieldLoadingContainer(TextLoadingStyle.LOADING_STYLE_RATING);
      }
      
      public function clearUserName() : void
      {
         this.setUserNameHtmlText(Values.EMPTY_STR);
      }
      
      public function clearUserRating() : void
      {
         this.setUserRatingHtmlText(Values.EMPTY_STR);
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this._userName.dispose();
         this._userName = null;
         this._userRating.dispose();
         this._userRating = null;
      }
      
      public function getIsUserNameLoading() : Boolean
      {
         return this._userName.isLoading() || !this._userName.isUserNameSetFromProps;
      }
      
      public function setControlledUserNameTextField(param1:TextField) : void
      {
         this._userName.setControlledTextField(param1);
      }
      
      public function setControlledUserRatingTextField(param1:TextField) : void
      {
         this._userRating.setControlledTextField(param1);
      }
      
      public function setUserNameFromProps(param1:IUserProps) : void
      {
         if(param1.userName == EMPTY_USER_NAME)
         {
            this._userName.setTextFieldIsLoading(true);
            this._userRating.hide();
            return;
         }
         var _loc2_:String = this._userName.setUserNameFromProps(param1);
         this.setUserNameHtmlText(_loc2_);
         this._userName.isUserNameSetFromProps = true;
      }
      
      public function setUserNameHtmlText(param1:String) : void
      {
         this._userName.setHtmlText(param1);
         this._userName.isUserNameSetFromProps = false;
         this._userRating.show();
         this._userName.setTextFieldIsLoading(false);
         dispatchEvent(new UserInfoTextEvent(UserInfoTextEvent.USER_NAME_CHANGED));
      }
      
      public function setUserRatingHtmlText(param1:String) : void
      {
         this._userRating.setHtmlText(param1);
         if(param1 != EMPTY_USER_RATING)
         {
            this._userRating.setTextFieldIsLoading(false);
         }
         if(this._userName.isLoading())
         {
            this._userRating.hide();
         }
         dispatchEvent(new UserInfoTextEvent(UserInfoTextEvent.USER_RATING_CHANGED));
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
