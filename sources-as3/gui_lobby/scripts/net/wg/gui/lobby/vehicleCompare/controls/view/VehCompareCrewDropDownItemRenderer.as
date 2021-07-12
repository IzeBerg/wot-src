package net.wg.gui.lobby.vehicleCompare.controls.view
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.lobby.vehicleCompare.data.VehCompareCrewLevelVO;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.utils.Constraints;
   
   public class VehCompareCrewDropDownItemRenderer extends SoundListItemRenderer
   {
      
      private static const ALLERT_OFFSET_X:int = 6;
      
      private static const ALLERT_Y:int = 2;
       
      
      public var alertIcon:Sprite;
      
      private var _crewData:VehCompareCrewLevelVO = null;
      
      public function VehCompareCrewDropDownItemRenderer()
      {
         super();
         this.alertIcon.visible = false;
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         App.toolTipMgr.hide();
         this._crewData = VehCompareCrewLevelVO(param1);
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         constraints.addElement(this.alertIcon.name,this.alertIcon,0);
         constraints.addElement(textField.name,textField,Constraints.LEFT);
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onHideTooltipHandler);
         addEventListener(MouseEvent.CLICK,this.onHideTooltipHandler);
         App.utils.commons.updateChildrenMouseEnabled(this,false);
      }
      
      override protected function onDispose() : void
      {
         this._crewData = null;
         this.alertIcon = null;
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onHideTooltipHandler);
         removeEventListener(MouseEvent.CLICK,this.onHideTooltipHandler);
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         super.draw();
         if(this._crewData && isInvalid(InvalidationType.DATA))
         {
            this.alertIcon.visible = this._crewData.showAlert;
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = textField.x + textField.textWidth * textField.scaleX;
            this.alertIcon.x = (_loc1_ * scaleX + ALLERT_OFFSET_X | 0) / scaleX;
            this.alertIcon.y = ALLERT_Y / scaleY;
         }
      }
      
      private function onHideTooltipHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         if(this._crewData && StringUtils.isNotEmpty(this._crewData.tooltip))
         {
            App.toolTipMgr.show(this._crewData.tooltip);
         }
      }
   }
}
