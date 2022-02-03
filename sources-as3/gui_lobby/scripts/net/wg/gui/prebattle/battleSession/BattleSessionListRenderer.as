package net.wg.gui.prebattle.battleSession
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.SoundManagerStates;
   import net.wg.data.constants.SoundTypes;
   import net.wg.gui.components.controls.TextFieldShort;
   import scaleform.clik.utils.Constraints;
   
   public class BattleSessionListRenderer extends TextFieldShort
   {
      
      private static const INVALIDATE_DATA:String = "invalidateData";
       
      
      public var opponentsField:TextField;
      
      public var startSettings:BSStartSettingsInfo;
      
      public var icon:MovieClip;
      
      private var dataVO:BSListRendererVO = null;
      
      public function BattleSessionListRenderer()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         this.dataVO = BSListRendererVO(param1);
         visible = this.dataVO != null;
         if(visible)
         {
            label = this.dataVO.descr;
            invalidate(INVALIDATE_DATA);
            validateNow();
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.shadowColor = "Black";
         this.textColor = 16777215;
         this.textSize = 15;
         constraints.addElement("opponentsField",this.opponentsField,Constraints.ALL);
         constraints.addElement("startSettings",this.startSettings,Constraints.ALL);
         constraints.addElement(this.icon.name,this.icon,Constraints.LEFT | Constraints.TOP);
      }
      
      override protected function onDispose() : void
      {
         this.startSettings.dispose();
         this.startSettings = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALIDATE_DATA) && this.dataVO)
         {
            this.afterSetData();
         }
      }
      
      private function afterSetData() : void
      {
         textField.text = this.dataVO.descr;
         this.opponentsField.text = this.dataVO.opponents;
         this.startSettings.updateData(this.dataVO.prbType,this.dataVO.startTime,this.dataVO.unitName,this.dataVO.vehicleLevel);
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         super.handleMouseRollOver(param1);
         App.soundMgr.playControlsSnd(SoundManagerStates.SND_OVER,SoundTypes.NORMAL_BTN,null);
      }
      
      override protected function handleMousePress(param1:MouseEvent) : void
      {
         super.handleMousePress(param1);
         App.soundMgr.playControlsSnd(SoundManagerStates.SND_PRESS,SoundTypes.NORMAL_BTN,null);
      }
   }
}
