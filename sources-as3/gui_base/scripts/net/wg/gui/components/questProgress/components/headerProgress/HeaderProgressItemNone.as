package net.wg.gui.components.questProgress.components.headerProgress
{
   import flash.display.Sprite;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.questProgress.interfaces.components.IHeaderProgressItem;
   import net.wg.gui.components.questProgress.interfaces.data.IHeaderProgressData;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class HeaderProgressItemNone extends UIComponentEx implements IHeaderProgressItem
   {
       
      
      public var line:Sprite = null;
      
      private var _data:IHeaderProgressData = null;
      
      private var _maxWidth:int = 0;
      
      public function HeaderProgressItemNone()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.onDataUpdate(this._data,this._maxWidth);
         }
      }
      
      override protected function onDispose() : void
      {
         this.line = null;
         this._data = null;
         super.onDispose();
      }
      
      public function setData(param1:IHeaderProgressData, param2:int) : void
      {
         if(param1 != null)
         {
            this._data = param1;
            this._maxWidth = param2;
            invalidateData();
         }
      }
      
      public function update(param1:IHeaderProgressData) : void
      {
         if(param1 != null)
         {
            this._data = param1;
            invalidateData();
         }
      }
      
      protected function onDataUpdate(param1:IHeaderProgressData, param2:int) : void
      {
         if(this.line)
         {
            this.line.width = param2;
         }
      }
      
      public function get orderType() : String
      {
         return this._data != null ? this._data.orderType : Values.EMPTY_STR;
      }
   }
}
