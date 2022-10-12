package net.wg.gui.battle.comp7.stats.components.playersPanel.list
{
   import flash.geom.Rectangle;
   import net.wg.gui.battle.comp7.stats.components.VoiceChatActivation;
   import net.wg.gui.battle.comp7.stats.components.data.VoiceChatActivationVO;
   import net.wg.gui.battle.comp7.stats.components.playersPanel.interfaces.IComp7PlayersPanelListLeft;
   
   public class Comp7PlayersPanelListLeft extends Comp7PlayersPanelList implements IComp7PlayersPanelListLeft
   {
      
      private static const LINKAGE:String = "Comp7PlayersPanelListItemLeftUI";
      
      private static const NAME:String = "[WG Comp7PlayersPanelListLeft]";
      
      private static const WIDTH:uint = 485;
       
      
      public var voiceChatActivation:VoiceChatActivation = null;
      
      public function Comp7PlayersPanelListLeft()
      {
         super();
      }
      
      override public function getRenderersVisibleWidth() : uint
      {
         var _loc1_:Rectangle = renderersContainer.getBounds(this);
         return _loc1_.x + WIDTH;
      }
      
      override public function toString() : String
      {
         return NAME;
      }
      
      override protected function onDispose() : void
      {
         this.voiceChatActivation.dispose();
         this.voiceChatActivation = null;
         super.onDispose();
      }
      
      public function setVoiceChatControlActive(param1:Boolean) : void
      {
         this.voiceChatActivation.setIsActive(param1);
      }
      
      public function setVoiceChatData(param1:VoiceChatActivationVO) : void
      {
         this.voiceChatActivation.setData(param1);
      }
      
      public function setVoiceChatVisibility(param1:Boolean) : void
      {
         this.voiceChatActivation.visible = param1;
      }
      
      override protected function get itemLinkage() : String
      {
         return LINKAGE;
      }
      
      override protected function get isRightAligned() : Boolean
      {
         return false;
      }
   }
}
