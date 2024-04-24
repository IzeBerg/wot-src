package net.wg.gui.lobby.missions.components.headerComponents
{
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.gui.lobby.missions.data.CurrentVehicleHeaderTitleBlockVO;
   import net.wg.infrastructure.interfaces.IImage;
   import scaleform.clik.constants.InvalidationType;
   
   public class CurrentVehicleHeaderTitleBlock extends HeaderTitleBlockBase
   {
      
      private static const TITLE_X_SHIFT:int = 14;
      
      private static const TANK_TYPE_X_SHIFT:int = -14;
      
      private static const TANK_INFO_X_SHIFT:int = -17;
       
      
      public var tankType:IImage;
      
      public var tankInfo:TextField;
      
      private var _data:CurrentVehicleHeaderTitleBlockVO;
      
      private var _isTankTypeLoaded:Boolean = false;
      
      public function CurrentVehicleHeaderTitleBlock()
      {
         super();
      }
      
      override public function update(param1:Object) : void
      {
         super.update(param1);
         this._data = CurrentVehicleHeaderTitleBlockVO(param1);
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.tankType.addEventListener(Event.CHANGE,this.onTankTypeChangeHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.tankType.source = this._data.tankType;
            this.tankInfo.htmlText = this._data.tankInfo;
         }
         if(this._isTankTypeLoaded && isInvalid(InvalidationType.SIZE))
         {
            title.x = (width - (title.textWidth + this.tankType.width + this.tankInfo.textWidth) >> 1) + TITLE_X_SHIFT;
            this.tankType.x = title.x + title.textWidth + TANK_TYPE_X_SHIFT | 0;
            this.tankInfo.x = this.tankType.x + this.tankType.width + TANK_INFO_X_SHIFT;
         }
      }
      
      override protected function onDispose() : void
      {
         this.tankType.removeEventListener(Event.CHANGE,this.onTankTypeChangeHandler);
         this.tankType.dispose();
         this.tankType = null;
         this.tankInfo = null;
         this._data = null;
         super.onDispose();
      }
      
      private function onTankTypeChangeHandler(param1:Event) : void
      {
         this._isTankTypeLoaded = true;
         invalidateSize();
      }
   }
}
