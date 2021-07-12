package net.wg.gui.lobby.manualChapter.controls
{
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   
   public class PageContentTemplate extends UIComponentEx
   {
       
      
      private var _data:IDAAPIDataClass;
      
      private var _contentScale:Number;
      
      private var _fadingIn:Boolean = false;
      
      public function PageContentTemplate()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this._data.dispose();
         this._data = null;
         super.onDispose();
      }
      
      public function fadeIn() : void
      {
         this._fadingIn = true;
         invalidateState();
      }
      
      public function fadeOut() : void
      {
         this._fadingIn = false;
         invalidateState();
      }
      
      public function isSeparated() : Boolean
      {
         return true;
      }
      
      public function isCentered() : Boolean
      {
         return true;
      }
      
      public function setData(param1:Object) : void
      {
         this._data = this.getDataVO(param1);
         invalidateData();
      }
      
      public function updateScaleFactor(param1:Number) : void
      {
         this._contentScale = param1;
         invalidateSize();
      }
      
      protected function isFadingIn() : Boolean
      {
         return this._fadingIn;
      }
      
      protected function getContentScale() : Number
      {
         return this._contentScale;
      }
      
      protected function getData() : IDAAPIDataClass
      {
         return this._data;
      }
      
      protected function getDataVO(param1:Object) : IDAAPIDataClass
      {
         return null;
      }
   }
}
