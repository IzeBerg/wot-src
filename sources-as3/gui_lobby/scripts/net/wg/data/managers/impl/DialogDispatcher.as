package net.wg.data.managers.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.exceptions.ArgumentException;
   import net.wg.infrastructure.interfaces.IDialogDispatcher;
   
   public class DialogDispatcher implements IDialogDispatcher
   {
       
      
      private var _onClose:Function = null;
      
      private var _onSubmit:Function = null;
      
      private var _onButtonClick:Function = null;
      
      private var _handlersInfo:Array = null;
      
      private var _disposed:Boolean = false;
      
      public function DialogDispatcher()
      {
         super();
      }
      
      public function set onClose(param1:Function) : void
      {
         this._onClose = param1;
      }
      
      public function get onClose() : Function
      {
         return this._onClose;
      }
      
      public function set onButtonClick(param1:Function) : void
      {
         this._onButtonClick = param1;
      }
      
      public function get onButtonClick() : Function
      {
         return this._onButtonClick;
      }
      
      public function set onSubmit(param1:Function) : void
      {
         this._onSubmit = param1;
      }
      
      public function get onSubmit() : Function
      {
         return this._onSubmit;
      }
      
      public function set handlersInfo(param1:Array) : void
      {
         var _loc3_:String = null;
         var _loc2_:Number = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = _loc2_ + " element in handlersInfo";
            if(_loc2_ % 2 == 0)
            {
               App.utils.asserter.assertNotNull(param1[_loc2_],_loc3_ + Errors.CANT_NULL);
               this.assertType(param1[_loc2_],String,_loc3_);
            }
            else
            {
               this.assertType(param1[_loc2_],Function,_loc3_);
            }
            _loc2_++;
         }
         this._handlersInfo = param1;
      }
      
      private function assertType(param1:Object, param2:Class, param3:String) : void
      {
         var _loc4_:String = param3 + " must be " + param2 + "!";
         if(param1 != null)
         {
            App.utils.asserter.assert(param1 is param2,_loc4_,ArgumentException);
         }
      }
      
      public function get handlersInfo() : Array
      {
         return this._handlersInfo;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this._handlersInfo = null;
         this._onSubmit = null;
         this._onButtonClick = null;
         this._onClose = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
