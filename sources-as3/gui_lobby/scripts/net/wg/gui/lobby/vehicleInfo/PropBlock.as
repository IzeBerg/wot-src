package net.wg.gui.lobby.vehicleInfo
{
   import flash.text.TextField;
   import flash.text.TextFormatAlign;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.lobby.vehicleInfo.data.VehicleInfoPropBlockVO;
   import net.wg.infrastructure.base.SimpleDisposable;
   import net.wg.infrastructure.managers.counter.CounterManager;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICounterManager;
   import net.wg.utils.ICounterProps;
   
   public class PropBlock extends SimpleDisposable implements IVehicleInfoBlock
   {
      
      private static const COUNTER_OFFSET_X:int = -10;
      
      private static const COUNTER_OFFSET_Y:int = -11;
       
      
      public var propValue:TextField;
      
      public var propName:TextField;
      
      private var _counterManager:ICounterManager;
      
      public function PropBlock()
      {
         this._counterManager = App.utils.counterManager;
         super();
         this.propValue.selectable = false;
         this.propName.selectable = false;
      }
      
      override protected function onDispose() : void
      {
         this._counterManager.removeCounter(this);
         this._counterManager = null;
         this.propValue = null;
         this.propName = null;
         super.onDispose();
      }
      
      public function setData(param1:Object) : void
      {
         var _loc3_:ICounterProps = null;
         var _loc2_:VehicleInfoPropBlockVO = VehicleInfoPropBlockVO(param1);
         this.propValue.text = _loc2_.value;
         this.propName.text = MENU.vehicleinfo_params(_loc2_.name);
         if(_loc2_.highlight)
         {
            _loc3_ = new CounterProps(COUNTER_OFFSET_X,COUNTER_OFFSET_Y,TextFormatAlign.LEFT,true,Linkages.COUNTER_LINE_BIG_UI);
            this._counterManager.setCounter(this,CounterManager.COUNTER_EMPTY,null,_loc3_);
         }
      }
   }
}
