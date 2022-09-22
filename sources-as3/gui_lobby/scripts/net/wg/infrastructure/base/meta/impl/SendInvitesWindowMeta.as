package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class SendInvitesWindowMeta extends AbstractWindowView
   {
       
      
      public var showError:Function;
      
      public var setOnlineFlag:Function;
      
      public var sendInvites:Function;
      
      public var getAllAvailableContacts:Function;
      
      private var _vectorString:Vector.<String>;
      
      public function SendInvitesWindowMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._vectorString)
         {
            this._vectorString.splice(0,this._vectorString.length);
            this._vectorString = null;
         }
         super.onDispose();
      }
      
      public function showErrorS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.showError,"showError" + Errors.CANT_NULL);
         this.showError(param1);
      }
      
      public function setOnlineFlagS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.setOnlineFlag,"setOnlineFlag" + Errors.CANT_NULL);
         this.setOnlineFlag(param1);
      }
      
      public function sendInvitesS(param1:Array, param2:String) : void
      {
         App.utils.asserter.assertNotNull(this.sendInvites,"sendInvites" + Errors.CANT_NULL);
         this.sendInvites(param1,param2);
      }
      
      public function getAllAvailableContactsS() : Array
      {
         App.utils.asserter.assertNotNull(this.getAllAvailableContacts,"getAllAvailableContacts" + Errors.CANT_NULL);
         return this.getAllAvailableContacts();
      }
      
      public final function as_setInvalidUserTags(param1:Array) : void
      {
         var _loc2_:Vector.<String> = this._vectorString;
         this._vectorString = new Vector.<String>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._vectorString[_loc4_] = param1[_loc4_];
            _loc4_++;
         }
         this.setInvalidUserTags(this._vectorString);
         if(_loc2_)
         {
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      protected function setInvalidUserTags(param1:Vector.<String>) : void
      {
         var _loc2_:String = "as_setInvalidUserTags" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
