package net.wg.data.managers.impl
{
   import net.wg.infrastructure.interfaces.INotifyProperties;
   
   public class NotifyProperties implements INotifyProperties
   {
       
      
      private var _imageUrl:String = null;
      
      private var _msgArgs:Array = null;
      
      private var _titleArgs:Array = null;
      
      private var _disposed:Boolean = false;
      
      public function NotifyProperties()
      {
         super();
      }
      
      public function set imgUrl(param1:String) : void
      {
         this._imageUrl = param1;
      }
      
      public function get imgUrl() : String
      {
         return this._imageUrl;
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this._imageUrl = null;
         this._msgArgs = null;
         this._titleArgs = null;
      }
      
      public function set messageArguments(param1:Array) : void
      {
         this._msgArgs = param1;
      }
      
      public function get messageArguments() : Array
      {
         return this._msgArgs;
      }
      
      public function set titleArguments(param1:Array) : void
      {
         this._titleArgs = param1;
      }
      
      public function get titleArguments() : Array
      {
         return this._titleArgs;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
