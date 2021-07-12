package net.wg.gui.components.questProgress.components.headerProgress
{
   import net.wg.gui.components.questProgress.interfaces.components.IHeaderProgress;
   import net.wg.gui.components.questProgress.interfaces.data.IHeaderProgressData;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class HeaderProgressBase extends UIComponentEx implements IHeaderProgress
   {
       
      
      private var _maxWidth:int = 0;
      
      private var _data:IHeaderProgressData = null;
      
      public function HeaderProgressBase()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.onDataUpdate(this._maxWidth,this._data);
         }
      }
      
      override protected function onDispose() : void
      {
         this._data = null;
         super.onDispose();
      }
      
      public function setData(param1:IHeaderProgressData, param2:int) : void
      {
         if(this._data != param1 && param1 != null)
         {
            this._data = param1;
            this._maxWidth = param2;
            invalidateData();
         }
      }
      
      protected function onDataUpdate(param1:int, param2:IHeaderProgressData) : void
      {
      }
   }
}
