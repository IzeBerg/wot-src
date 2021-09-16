package net.wg.gui.battle.views.damagePanel.components.tankIndicator
{
   import net.wg.gui.battle.views.damagePanel.components.DamagePanelItemFrameStates;
   
   public class SPGRotator extends TankRotator
   {
       
      
      public var radio:DamagePanelItemFrameStates;
      
      public var surveyingDevice:DamagePanelItemFrameStates;
      
      public function SPGRotator()
      {
         super();
      }
      
      override protected function getModules() : Vector.<DamagePanelItemFrameStates>
      {
         return super.getModules().concat(new <DamagePanelItemFrameStates>[this.radio,this.surveyingDevice,ammoBay]);
      }
      
      override protected function onDispose() : void
      {
         this.radio.dispose();
         this.radio = null;
         this.surveyingDevice.dispose();
         this.surveyingDevice = null;
         ammoBay.dispose();
         ammoBay = null;
         super.onDispose();
      }
   }
}
