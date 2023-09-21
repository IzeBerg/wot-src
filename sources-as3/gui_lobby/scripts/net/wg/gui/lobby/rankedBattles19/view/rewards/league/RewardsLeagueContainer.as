package net.wg.gui.lobby.rankedBattles19.view.rewards.league
{
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.RANKEDBATTLES_ALIASES;
   import net.wg.gui.lobby.rankedBattles19.data.RewardsLeagueRendererVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class RewardsLeagueContainer extends Sprite implements IDisposable
   {
      
      private static const DATA_ERROR:String = "[RewardsLeagueContainer] Amount of renderers dosn\'t equal amount of data length";
       
      
      private var _renderers:Vector.<RewardsLeagueRenderer> = null;
      
      private var _rewardsData:Vector.<RewardsLeagueRendererVO>;
      
      private var _rendererWidth:int = 320;
      
      private var _styleIconWidth:int = 300;
      
      private var _renderersWidth:Number = 0;
      
      private var _disposed:Boolean = false;
      
      public function RewardsLeagueContainer()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.clearRenderers();
      }
      
      public function setRendererWidth(param1:int, param2:int) : void
      {
         if(this._rendererWidth == param1 && this._styleIconWidth == param2)
         {
            return;
         }
         this._rendererWidth = param1;
         this._styleIconWidth = param2;
         this.updateRenderersSize();
         this.updateRenderersPositions();
      }
      
      private function updateRenderers() : void
      {
         var _loc1_:int = 0;
         if(this._rewardsData && this._rewardsData.length > 0)
         {
            _loc1_ = this._rewardsData.length;
            if(!this._renderers)
            {
               this._renderers = new Vector.<RewardsLeagueRenderer>();
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
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this._renderers[_loc2_].setData(this._rewardsData[_loc2_]);
            this._renderers[_loc2_].setRendererWidth(this._rendererWidth,this._styleIconWidth);
            this._renderers[_loc2_].validateNow();
            _loc2_++;
         }
      }
      
      private function addRenderers(param1:int) : void
      {
         var _loc3_:RewardsLeagueRenderer = null;
         var _loc4_:int = 0;
         var _loc2_:int = param1 - this._renderers.length;
         if(_loc2_ > 0)
         {
            _loc3_ = null;
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               _loc3_ = App.utils.classFactory.getComponent(RANKEDBATTLES_ALIASES.RANKED_BATTLES_REWARD_LEAGUE_RENDERER_UI,RewardsLeagueRenderer);
               this._renderers.push(_loc3_);
               this.addChild(_loc3_);
               _loc4_++;
            }
         }
      }
      
      private function removeRenderers(param1:int) : void
      {
         var _loc3_:RewardsLeagueRenderer = null;
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
         var _loc2_:RewardsLeagueRenderer = null;
         var _loc3_:int = 0;
         this._rewardsData = null;
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
            this._renderersWidth = this._rendererWidth * _loc1_;
            _loc3_ = -(this._renderersWidth >> 1);
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               this._renderers[_loc2_].x = _loc3_;
               _loc3_ += this._rendererWidth;
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
               this._renderers[_loc2_].setRendererWidth(this._rendererWidth,this._styleIconWidth);
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
         return this._renderers && this._renderers.length > 0 ? Number(this._renderers[0].height) : Number(Values.ZERO);
      }
      
      public function set data(param1:Vector.<RewardsLeagueRendererVO>) : void
      {
         this._rewardsData = param1;
         this.updateRenderers();
         this.updateRenderersPositions();
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
