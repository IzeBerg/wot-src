package net.wg.gui.bootcamp.battleResult.containers.base
{
   import net.wg.gui.bootcamp.battleResult.events.BattleViewEvent;
   import net.wg.gui.components.containers.GroupEx;
   
   public class BattleResultsGroup extends GroupEx
   {
       
      
      private var _elementId:String = "";
      
      private var _loadedRenderers:int = 0;
      
      public function BattleResultsGroup()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(BattleViewEvent.RENDERER_LOADED,this.onRendererLoadedHandler);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(BattleViewEvent.RENDERER_LOADED,this.onRendererLoadedHandler);
         this._loadedRenderers = 0;
         this._elementId = null;
         super.onDispose();
      }
      
      public function showAppearAnimation() : void
      {
         var _loc2_:BaseRendererContainer = null;
         var _loc1_:int = numRenderers();
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = BaseRendererContainer(getRendererAt(_loc3_));
            _loc2_.showAnimation();
            _loc3_++;
         }
         dispatchEvent(new BattleViewEvent(BattleViewEvent.ANIMATION_START,this._elementId,true));
      }
      
      public function set elementId(param1:String) : void
      {
         this._elementId = param1;
      }
      
      private function onRendererLoadedHandler(param1:BattleViewEvent) : void
      {
         ++this._loadedRenderers;
         if(this._loadedRenderers >= renderers.length)
         {
            dispatchEvent(new BattleViewEvent(BattleViewEvent.ALL_RENDERERS_LOADED,this._elementId,true));
         }
      }
   }
}
