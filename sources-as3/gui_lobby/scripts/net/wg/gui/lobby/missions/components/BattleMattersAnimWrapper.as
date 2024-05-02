package net.wg.gui.lobby.missions.components
{
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.events.ViewStackEvent;
   import net.wg.gui.lobby.battleMatters.BattleMattersAnimLoaderView;
   import net.wg.gui.lobby.battleMatters.data.BattleMattersAnimVO;
   import net.wg.gui.lobby.missions.MissionsPage;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.BlurHelper;
   
   public class BattleMattersAnimWrapper extends UIComponentEx
   {
      
      private static const ANIMATION_SWF_PATH:String = "./battleMattersAnimLoader.swf";
       
      
      private var _missionPage:MissionsPage;
      
      private var _animationView:BattleMattersAnimLoaderView;
      
      private var _loader:Loader;
      
      private var _blurHelper:BlurHelper;
      
      private var _animPath:String = "";
      
      private var _data:BattleMattersAnimVO;
      
      public function BattleMattersAnimWrapper(param1:MissionsPage)
      {
         this._loader = new Loader();
         this._blurHelper = new BlurHelper();
         super();
         this._missionPage = param1;
         this._missionPage.viewStack.addEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewChangedHandler);
      }
      
      override protected function onDispose() : void
      {
         this._missionPage.viewStack.removeEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewChangedHandler);
         this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoaderCompleteHandler);
         this._loader.unloadAndStop();
         this._loader = null;
         this._missionPage = null;
         if(this._animationView)
         {
            this._animationView.removeEventListener(BattleMattersAnimLoaderView.LOADING_COMPLETE,this.onAnimLoadingComplete);
            this._animationView.removeEventListener(BattleMattersAnimLoaderView.ON_CLOSE,this.onAnimCloseHandler);
            this._animationView.dispose();
         }
         this._animationView = null;
         this._blurHelper.dispose();
         this._blurHelper = null;
         this._data = null;
         super.onDispose();
      }
      
      public function showAnimation(param1:String, param2:BattleMattersAnimVO) : void
      {
         var _loc3_:LoaderContext = null;
         this._animPath = param1;
         this._data = param2;
         if(this._animationView)
         {
            this._animationView.showAnimation(param1,this._data);
         }
         else
         {
            _loc3_ = new LoaderContext(false,ApplicationDomain.currentDomain);
            this._loader.load(new URLRequest(ANIMATION_SWF_PATH),_loc3_);
            this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoaderCompleteHandler);
         }
      }
      
      public function updateStage(param1:int, param2:int) : void
      {
         setSize(param1,param2);
         if(this._animationView)
         {
            this._animationView.updateStage(param1,param2);
         }
      }
      
      private function hide() : void
      {
         this._blurHelper.unblurElements(new <DisplayObject>[this._missionPage.viewStack]);
         this._animationView.visible = false;
      }
      
      private function onViewChangedHandler(param1:ViewStackEvent) : void
      {
         this.hide();
      }
      
      private function onAnimCloseHandler(param1:Event) : void
      {
         this.hide();
      }
      
      private function onAnimLoadingComplete(param1:Event) : void
      {
         this._blurHelper.blurElements(new <DisplayObject>[this._missionPage.viewStack]);
         this._animationView.visible = true;
      }
      
      private function onLoaderCompleteHandler(param1:Event) : void
      {
         this._animationView = App.utils.classFactory.getComponent(Linkages.BATTLE_MATTERS_ANIM_LOADER,BattleMattersAnimLoaderView);
         this._animationView.updateStage(_width,_height);
         this._animationView.addEventListener(BattleMattersAnimLoaderView.LOADING_COMPLETE,this.onAnimLoadingComplete);
         this._animationView.addEventListener(BattleMattersAnimLoaderView.ON_CLOSE,this.onAnimCloseHandler);
         addChild(this._animationView);
         this._animationView.visible = false;
         this._animationView.showAnimation(this._animPath,this._data);
      }
   }
}
