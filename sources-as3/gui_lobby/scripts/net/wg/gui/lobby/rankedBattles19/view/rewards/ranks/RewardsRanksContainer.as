package net.wg.gui.lobby.rankedBattles19.view.rewards.ranks
{
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.data.constants.generated.RANKEDBATTLES_ALIASES;
   import net.wg.data.constants.generated.RANKEDBATTLES_CONSTS;
   import net.wg.gui.lobby.rankedBattles19.data.RewardsRankRendererVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.interfaces.entity.IDraggable;
   
   public class RewardsRanksContainer extends Sprite implements IDisposable
   {
      
      private static const DATA_ERROR:String = "[RewardsRanksContainer] Amount of renderers dosn\'t equal amount of data length";
       
      
      private var _screen:IDraggable = null;
      
      private var _renderers:Vector.<RewardsRankRenderer> = null;
      
      private var _currentRenderer:RewardsRankRenderer = null;
      
      private var _rewardsData:Vector.<RewardsRankRendererVO>;
      
      private var _rendererWidth:int;
      
      private var _rendererHeight:int = 0;
      
      private var _renderersWidth:Number = 0;
      
      private var _bonusSizeID:String = "";
      
      public function RewardsRanksContainer()
      {
         this._rendererWidth = RewardsRankRenderer.RENDERER_WIDTH_NARROW;
         super();
      }
      
      public final function dispose() : void
      {
         this._screen = null;
         this.clearRenderers();
      }
      
      public function getSelectedRendererXPos() : int
      {
         return Boolean(this._currentRenderer) ? int(this._currentRenderer.x) : int(-(this._renderersWidth >> 1));
      }
      
      public function setRendererWidth(param1:int, param2:Boolean) : void
      {
         if(this._rendererWidth == param1)
         {
            return;
         }
         this._rendererWidth = param1;
         if(param2)
         {
            this.updateRenderersSize();
            this.updateRenderersPositions();
         }
      }
      
      private function updateRenderers() : void
      {
         var _loc1_:int = 0;
         if(this._rewardsData && this._rewardsData.length > 0)
         {
            _loc1_ = this._rewardsData.length;
            if(!this._renderers)
            {
               this._renderers = new Vector.<RewardsRankRenderer>();
            }
            this.removeRenderers(_loc1_);
            this.addRenderers(_loc1_);
            App.utils.asserter.assert(_loc1_ == this._renderers.length,DATA_ERROR);
            this.setupRenderers();
         }
      }
      
      private function setupRenderers() : void
      {
         var _loc1_:int = this._renderers.length;
         var _loc2_:int = _loc1_ - 1;
         var _loc3_:RewardsRankRenderer = null;
         var _loc4_:int = 0;
         this._currentRenderer = null;
         this._rendererHeight = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc1_)
         {
            _loc3_ = this._renderers[_loc4_];
            _loc3_.setData(this._screen,this,this._bonusSizeID,this._rewardsData[_loc4_],_loc4_ == 0,_loc4_ == _loc2_);
            _loc3_.rendererWidth = this._rendererWidth;
            _loc3_.validateNow();
            this._rendererHeight = Math.max(this._rendererHeight,_loc3_.bonusesHeight);
            if(this._rewardsData[_loc4_].state == RANKEDBATTLES_CONSTS.RANKED_REWARDS_RANK_CURRENT)
            {
               this._currentRenderer = _loc3_;
            }
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc1_)
         {
            this._renderers[_loc4_].rendererHeight = this._rendererHeight;
            _loc4_++;
         }
      }
      
      private function addRenderers(param1:int) : void
      {
         var _loc3_:RewardsRankRenderer = null;
         var _loc4_:int = 0;
         var _loc2_:int = param1 - this._renderers.length;
         if(_loc2_ > 0)
         {
            _loc3_ = null;
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               _loc3_ = App.utils.classFactory.getComponent(RANKEDBATTLES_ALIASES.RANKED_BATTLES_REWARD_RANK_RENDERER_UI,RewardsRankRenderer);
               this._renderers.push(_loc3_);
               this.addChild(_loc3_);
               _loc4_++;
            }
         }
      }
      
      private function removeRenderers(param1:int) : void
      {
         var _loc3_:RewardsRankRenderer = null;
         var _loc4_:int = 0;
         var _loc2_:int = this._renderers.length - param1;
         if(_loc2_ > 0)
         {
            _loc3_ = null;
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               _loc3_ = this._renderers.pop();
               this.removeChild(_loc3_);
               _loc3_.dispose();
               _loc4_++;
            }
         }
      }
      
      private function clearRenderers() : void
      {
         var _loc1_:int = 0;
         var _loc2_:RewardsRankRenderer = null;
         var _loc3_:int = 0;
         this._rewardsData = null;
         this._currentRenderer = null;
         if(this._renderers)
         {
            _loc1_ = this._renderers.length;
            _loc2_ = null;
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               _loc2_ = this._renderers.pop();
               this.removeChild(_loc2_);
               _loc2_.dispose();
               _loc3_++;
            }
            this._renderers = null;
         }
      }
      
      private function updateRenderersPositions() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         this._renderersWidth = 0;
         if(this._renderers)
         {
            _loc1_ = this._renderers.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               this._renderersWidth += this._renderers[_loc2_].width;
               _loc2_++;
            }
            _loc3_ = -(this._renderersWidth >> 1);
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               this._renderers[_loc2_].x = _loc3_;
               _loc3_ += this._renderers[_loc2_].width;
               _loc2_++;
            }
         }
         dispatchEvent(new Event(Event.RESIZE));
      }
      
      private function updateRenderersSize() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this._renderers)
         {
            _loc1_ = this._renderers.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               this._renderers[_loc2_].rendererWidth = this._rendererWidth;
               _loc2_++;
            }
         }
      }
      
      override public function get width() : Number
      {
         return this._renderersWidth;
      }
      
      override public function get height() : Number
      {
         return this._rendererHeight;
      }
      
      public function set owner(param1:IDraggable) : void
      {
         this._screen = param1;
      }
      
      public function set data(param1:Vector.<RewardsRankRendererVO>) : void
      {
         this._rewardsData = param1;
         this.updateRenderers();
         this.updateRenderersPositions();
      }
      
      public function set bonusSizeID(param1:String) : void
      {
         this._bonusSizeID = param1;
      }
   }
}
