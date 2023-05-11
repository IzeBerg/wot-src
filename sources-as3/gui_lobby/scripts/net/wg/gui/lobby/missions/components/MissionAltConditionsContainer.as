package net.wg.gui.lobby.missions.components
{
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.interfaces.IUpdatableComponent;
   import net.wg.gui.lobby.missions.data.MissionAltConditionsContainerVO;
   import net.wg.gui.lobby.missions.data.MissionConditionsContainerVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class MissionAltConditionsContainer extends UIComponentEx implements IUpdatableComponent
   {
       
      
      public var labelTF:TextField = null;
      
      public var separator:DisplayObject = null;
      
      private var _data:MissionAltConditionsContainerVO = null;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function MissionAltConditionsContainer()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.ROLL_OUT,this.onContainerRollOutHandler);
         addEventListener(MouseEvent.ROLL_OVER,this.onContainerRollOverHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA) && this._data != null)
         {
            this.labelTF.htmlText = this._data.label;
            App.utils.commons.updateTextFieldSize(this.labelTF,true,false);
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.separator.y = 0;
            this.separator.x = width - this.separator.width >> 1;
            this.labelTF.x = width - this.labelTF.width >> 1;
         }
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onContainerRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onContainerRollOutHandler);
         this._data.dispose();
         this._data = null;
         this.labelTF = null;
         this.separator = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      public function update(param1:Object) : void
      {
         var _loc2_:MissionConditionsContainerVO = MissionConditionsContainerVO(param1);
         var _loc3_:MissionAltConditionsContainerVO = new MissionAltConditionsContainerVO(_loc2_.data);
         if(_loc3_ != this._data)
         {
            this._data = _loc3_;
            invalidateData();
         }
      }
      
      protected function hideTooltip() : void
      {
         this._toolTipMgr.hide();
      }
      
      protected function showTooltip() : void
      {
         if(StringUtils.isNotEmpty(this._data.tooltip))
         {
            this._toolTipMgr.show(this._data.tooltip);
         }
      }
      
      private function onContainerRollOverHandler(param1:MouseEvent) : void
      {
         this.showTooltip();
      }
      
      private function onContainerRollOutHandler(param1:MouseEvent) : void
      {
         this.hideTooltip();
      }
   }
}
