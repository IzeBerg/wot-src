package net.wg.gui.lobby.vehicleCompare.configurator
{
   import flash.display.MovieClip;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.components.data.DeviceSlotVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class VehConfModuleSlot extends UIComponentEx
   {
      
      private static const ALPHA_DISABLED:Number = 0.3;
      
      private static const ALPHA_ENABLED:Number = Values.DEFAULT_ALPHA;
       
      
      public var icon:UILoaderAlt;
      
      public var level:MovieClip;
      
      public var hit:MovieClip;
      
      private var _data:DeviceSlotVO;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function VehConfModuleSlot()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
         hitArea = this.hit;
         buttonMode = true;
         useHandCursor = true;
      }
      
      override protected function onDispose() : void
      {
         this._data = null;
         this.icon.dispose();
         this.icon = null;
         this.level = null;
         this.hit = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      public function setData(param1:DeviceSlotVO) : void
      {
         var _loc2_:Boolean = false;
         if(param1 != null && this._data != param1)
         {
            this._data = param1;
            this.level.gotoAndStop(param1.level);
            _loc2_ = StringUtils.isNotEmpty(this._data.tooltipType);
            alpha = !!_loc2_ ? Number(ALPHA_ENABLED) : Number(ALPHA_DISABLED);
            this.level.visible = _loc2_;
         }
      }
      
      public function showTooltip() : void
      {
         var _loc1_:String = this._data.tooltipType;
         if(StringUtils.isNotEmpty(_loc1_))
         {
            if(TOOLTIPS_CONSTANTS.COMPLEX == _loc1_)
            {
               this._toolTipMgr.showComplex(this._data.tooltip);
            }
            else if(!isNaN(this._data.id))
            {
               this._toolTipMgr.showSpecial(_loc1_,null,this._data.id,this._data.slotIndex);
            }
         }
      }
      
      public function set iconSource(param1:String) : void
      {
         this.icon.source = param1;
      }
   }
}
