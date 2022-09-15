package net.wg.gui.battle.comp7.stats.fullStats
{
   import net.wg.gui.battle.comp7.VO.daapi.Comp7InterestPointVO;
   import net.wg.gui.battle.comp7.infrastructure.interfaces.IPoiContainer;
   import net.wg.gui.battle.comp7.stats.components.VoiceChatActivation;
   import net.wg.gui.battle.comp7.stats.components.data.VoiceChatActivationVO;
   import net.wg.gui.battle.comp7.stats.components.events.VoiceChatActivationEvent;
   import net.wg.gui.battle.interfaces.ITabbedFullStatsTableController;
   import net.wg.infrastructure.base.meta.IComp7FullStatsMeta;
   import net.wg.infrastructure.base.meta.impl.Comp7FullStatsMeta;
   
   public class FullStats extends Comp7FullStatsMeta implements IPoiContainer, IComp7FullStatsMeta
   {
      
      private static const VOICE_CHAT_ACTIVATION_Y_SHIFT:int = -24;
       
      
      public var voiceChatActivation:VoiceChatActivation = null;
      
      private var _tableCtrl:FullStatsTableCtrl = null;
      
      public function FullStats()
      {
         super();
      }
      
      override public function getTableCtrl() : ITabbedFullStatsTableController
      {
         this._tableCtrl = new FullStatsTableCtrl(FullStatsTable(statsTable));
         return this._tableCtrl;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.voiceChatActivation.addEventListener(VoiceChatActivationEvent.CONTROL_CLICKED,this.onVoiceChatControlClickedHandler);
      }
      
      override protected function setVoiceChatData(param1:VoiceChatActivationVO) : void
      {
         this.voiceChatActivation.setData(param1);
      }
      
      override protected function doUpdateSizeTable(param1:Number, param2:Number) : void
      {
         super.doUpdateSizeTable(param1,param2);
         this.voiceChatActivation.y = statsTable.y + statsTable.height + VOICE_CHAT_ACTIVATION_Y_SHIFT | 0;
      }
      
      override protected function onDispose() : void
      {
         this.voiceChatActivation.removeEventListener(VoiceChatActivationEvent.CONTROL_CLICKED,this.onVoiceChatControlClickedHandler);
         this.voiceChatActivation.dispose();
         this.voiceChatActivation = null;
         this._tableCtrl = null;
         super.onDispose();
      }
      
      public function removePointOfInterest(param1:uint, param2:uint) : void
      {
         this._tableCtrl.removePointOfInterest(param1,param2);
      }
      
      public function updatePointOfInterest(param1:Comp7InterestPointVO, param2:Boolean = true) : void
      {
         this._tableCtrl.updatePointOfInterest(param1);
      }
      
      private function onVoiceChatControlClickedHandler(param1:VoiceChatActivationEvent) : void
      {
         onVoiceChatControlClickS();
      }
      
      public function as_setVoiceChatControlVisible(param1:Boolean) : void
      {
         this.voiceChatActivation.visible = param1;
      }
      
      public function as_setVoiceChatControlSelected(param1:Boolean) : void
      {
         this.voiceChatActivation.setIsActive(param1);
      }
   }
}
