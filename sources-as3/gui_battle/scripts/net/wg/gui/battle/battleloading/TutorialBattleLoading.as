package net.wg.gui.battle.battleloading
{
   import net.wg.data.VO.daapi.DAAPIArenaInfoVO;
   import net.wg.gui.battle.battleloading.vo.VisualTipInfoVO;
   import net.wg.gui.tutorial.controls.TipLoadingForm;
   import net.wg.infrastructure.base.meta.ITutorialLoadingMeta;
   import net.wg.infrastructure.base.meta.impl.TutorialLoadingMeta;
   
   public class TutorialBattleLoading extends TutorialLoadingMeta implements ITutorialLoadingMeta
   {
      
      private static const FORM_HEIGHT:Number = 752;
       
      
      public var form:TipLoadingForm;
      
      public function TutorialBattleLoading()
      {
         super();
      }
      
      override protected function setTutorialArenaInfo(param1:DAAPIArenaInfoVO) : void
      {
         this.form.setBattleTypeName(param1.battleTypeLocaleStr);
         this.form.updateMapName(param1.mapName);
         this.form.setBattleTypeFrameName(param1.battleTypeFrameLabel);
      }
      
      override public function as_setProgress(param1:Number) : void
      {
         this.form.updateProgress(param1);
      }
      
      override public function as_setTip(param1:String) : void
      {
         this.form.updateTipBody(param1);
      }
      
      override public function as_setTipTitle(param1:String) : void
      {
         this.form.updateTipTitle(param1);
      }
      
      override public function as_setMapIcon(param1:String) : void
      {
      }
      
      override protected function setVisualTipInfo(param1:VisualTipInfoVO) : void
      {
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         this.form.x = param1 >> 1;
         this.form.y = param2 - FORM_HEIGHT >> 1;
      }
      
      override protected function onDispose() : void
      {
         this.form.dispose();
         this.form = null;
         super.onDispose();
      }
   }
}
