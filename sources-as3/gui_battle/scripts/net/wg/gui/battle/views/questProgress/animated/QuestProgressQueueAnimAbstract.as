package net.wg.gui.battle.views.questProgress.animated
{
   import flash.display.DisplayObject;
   import flash.events.EventDispatcher;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.generated.BATTLE_SOUND;
   import net.wg.data.constants.generated.QUEST_PROGRESS_BATTLE;
   import net.wg.gui.battle.views.questProgress.interfaces.IQuestProgressView;
   import net.wg.infrastructure.interfaces.questProgress.IQueueAnimItemAbstract;
   
   public class QuestProgressQueueAnimAbstract extends EventDispatcher implements IQueueAnimControllerItem
   {
       
      
      private var _onComplete:Function = null;
      
      private var _anm:IQueueAnimItemAbstract = null;
      
      private var _view:IQuestProgressView = null;
      
      private var _container:IAnimationTopContainer = null;
      
      private var _viewAllowCallCompleteFn:Boolean = false;
      
      public function QuestProgressQueueAnimAbstract(param1:IQuestProgressView, param2:IQueueAnimItemAbstract, param3:IAnimationTopContainer)
      {
         super();
         this._view = param1;
         this._anm = param2;
         this._container = param3;
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      public final function onAnimStartCallback() : void
      {
         this.onAnimStart();
      }
      
      public final function onAnimStartSndCallBack(param1:String) : void
      {
         this.onAnimStartSnd(param1);
      }
      
      public final function onAnmCompleteCallback() : void
      {
         this.onAnimCompleted();
      }
      
      public final function onPreCompletedCallBack() : void
      {
         this.onPreCompletedAnim();
      }
      
      public final function run(param1:Function) : void
      {
         if(param1 == null)
         {
            App.utils.asserter.assert(false,"onComplete handler" + Errors.CANT_NULL);
         }
         this._onComplete = param1;
         this._container.addChild(DisplayObject(this._anm));
         this._anm.run(this.onAnmCompleteCallback,this.onPreCompletedCallBack,this.onAnimStartCallback,this.onAnimStartSndCallBack);
      }
      
      protected function onAnimCompleted() : void
      {
         if(this._viewAllowCallCompleteFn)
         {
            this._onComplete();
         }
      }
      
      protected function onPreCompletedAnim() : void
      {
         this._container.hide();
      }
      
      protected function onAnimStart() : void
      {
         this._container.show();
      }
      
      protected function onDispose() : void
      {
         this._onComplete = null;
         this._container.removeChild(DisplayObject(this._anm));
         this._anm.dispose();
         this._anm = null;
         this._view = null;
         this._container = null;
      }
      
      private function onAnimStartSnd(param1:String) : void
      {
         var _loc2_:String = param1 == QUEST_PROGRESS_BATTLE.QP_ANIM_STATUS_PROGRESS ? BATTLE_SOUND.SOUND_TYPE_QUEST_PROGRESS_TOP_PROGRESS_STEP : BATTLE_SOUND.SOUND_TYPE_QUEST_PROGRESS_TOP_FINAL_STEP;
         this._view.playSnd(_loc2_);
      }
      
      public function set viewAllowCallCompleteFn(param1:Boolean) : void
      {
         this._viewAllowCallCompleteFn = param1;
      }
   }
}
