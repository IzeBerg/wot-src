package net.wg.gui.battle.eventBattle.views.bossHP
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.infrastructure.base.meta.IEventBossHPBarMeta;
   import net.wg.infrastructure.base.meta.impl.EventBossHPBarMeta;
   
   public class BossHPBar extends EventBossHPBarMeta implements IEventBossHPBarMeta
   {
       
      
      public var nameTF:TextField = null;
      
      public var valueTF:TextField = null;
      
      public var progressBar:MovieClip = null;
      
      public var phaseIndicator:MovieClip = null;
      
      private var _label:String = "";
      
      private var _progress:int = -1;
      
      public function BossHPBar()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.nameTF.text = EVENT.BOT_NAME_G146_E100_HELL_BOSS;
      }
      
      public function as_setPhase(param1:int) : void
      {
         this.phaseIndicator.gotoAndStop(param1);
      }
      
      public function as_setBossHP(param1:String, param2:int) : void
      {
         this._progress = param2;
         this._label = param1;
         invalidateData();
      }
      
      public function as_setVisible(param1:Boolean) : void
      {
         if(visible != param1)
         {
            visible = param1;
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.valueTF.text = this._label;
            this.progressBar.gotoAndStop(this._progress);
         }
      }
      
      override protected function onDispose() : void
      {
         this.nameTF = null;
         this.valueTF = null;
         this.progressBar = null;
         this.phaseIndicator = null;
         super.onDispose();
      }
   }
}
