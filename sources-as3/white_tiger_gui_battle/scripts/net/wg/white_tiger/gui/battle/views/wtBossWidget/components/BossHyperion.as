package net.wg.white_tiger.gui.battle.views.wtBossWidget.components
{
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.components.controls.TextFieldContainer;
   
   public class BossHyperion extends BattleUIComponent
   {
      
      private static const FRAME_LABEL_SHIELD_ONLINE_HYPERION_OFFLINE:String = "hyperionOffShieldOn";
      
      private static const FRAME_LABEL_SHIELD_ONLINE_HYPERION_ONLINE:String = "hyperionOnShieldOn";
      
      private static const FRAME_LABEL_SHIELD_OFFLINE_HYPERION_OFFLINE:String = "hyperionOffShieldOff";
      
      private static const FRAME_LABEL_SHIELD_OFFLINE_HYPERION_ONLINE:String = "hyperionOnShieldOff";
       
      
      public var hyperionTF:TextFieldContainer = null;
      
      public function BossHyperion()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.hyperionTF = null;
         super.onDispose();
      }
      
      public function updateHyperionCharge(param1:Number, param2:Number, param3:Boolean) : void
      {
         var _loc4_:Boolean = param1 / param2 >= 1;
         if(currentFrameLabel != FRAME_LABEL_SHIELD_ONLINE_HYPERION_ONLINE && _loc4_ && param3)
         {
            gotoAndStop(FRAME_LABEL_SHIELD_ONLINE_HYPERION_ONLINE);
         }
         else if(currentFrameLabel != FRAME_LABEL_SHIELD_ONLINE_HYPERION_OFFLINE && !_loc4_ && param3)
         {
            gotoAndStop(FRAME_LABEL_SHIELD_ONLINE_HYPERION_OFFLINE);
         }
         else if(currentFrameLabel != FRAME_LABEL_SHIELD_OFFLINE_HYPERION_ONLINE && _loc4_ && !param3)
         {
            gotoAndStop(FRAME_LABEL_SHIELD_OFFLINE_HYPERION_ONLINE);
         }
         else if(currentFrameLabel != FRAME_LABEL_SHIELD_OFFLINE_HYPERION_OFFLINE && !_loc4_ && !param3)
         {
            gotoAndStop(FRAME_LABEL_SHIELD_OFFLINE_HYPERION_OFFLINE);
         }
         if(this.hyperionTF)
         {
            this.hyperionTF.label = param1 + "%";
         }
      }
   }
}
