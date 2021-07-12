package net.wg.gui.lobby.components
{
   import flash.display.DisplayObject;
   import net.wg.data.VO.AwardsItemVO;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.data.BaseAwardsBlockVO;
   import net.wg.gui.lobby.quests.components.interfaces.ITaskAwardItemRenderer;
   import net.wg.gui.lobby.quests.events.AwardWindowEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class BaseAwardsBlock extends UIComponentEx
   {
      
      private static const DEFAULT_BLOCKS_GAP:int = 20;
      
      private static const MIN_BLOCKS_GAP:int = 4;
       
      
      private var _awardsLength:int = 0;
      
      private var _awardsRenderers:Vector.<ITaskAwardItemRenderer> = null;
      
      private var _hasEqualPaddings:Boolean = false;
      
      public function BaseAwardsBlock()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.tryRemoveRenderers();
         super.onDispose();
      }
      
      public function setAwardsData(param1:BaseAwardsBlockVO) : void
      {
         var _loc3_:ITaskAwardItemRenderer = null;
         var _loc4_:int = 0;
         this.tryRemoveRenderers();
         var _loc2_:Vector.<AwardsItemVO> = param1.awards;
         this._awardsLength = _loc2_.length;
         if(this._awardsLength > 0)
         {
            this.validateAwardsData(_loc2_);
            this._awardsRenderers = new Vector.<ITaskAwardItemRenderer>(this._awardsLength,true);
            _loc3_ = null;
            _loc4_ = 0;
            while(_loc4_ < this._awardsLength)
            {
               _loc3_ = App.utils.classFactory.getComponent(Linkages.TASK_AWARD_RENDERER_LINKAGE,ITaskAwardItemRenderer);
               addChild(DisplayObject(_loc3_));
               if(_loc4_ >= this._awardsLength - 1)
               {
                  _loc3_.addEventListener(AwardWindowEvent.AWARD_RENDERER_READY,this.onLastRendererReadyHandler);
               }
               _loc3_.visible = false;
               _loc3_.setData(_loc2_[_loc4_]);
               this._awardsRenderers[_loc4_] = _loc3_;
               _loc4_++;
            }
         }
      }
      
      protected function getAvailableWidth() : int
      {
         return width;
      }
      
      protected function getAvailableHeight() : int
      {
         return height;
      }
      
      protected function getRenderersOffsetX() : int
      {
         return 0;
      }
      
      private function tryRemoveRenderers() : void
      {
         var _loc1_:ITaskAwardItemRenderer = null;
         var _loc2_:int = 0;
         if(this._awardsLength > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < this._awardsLength)
            {
               _loc1_ = this._awardsRenderers[_loc2_];
               _loc1_.removeEventListener(AwardWindowEvent.AWARD_RENDERER_READY,this.onLastRendererReadyHandler);
               _loc1_.dispose();
               removeChild(DisplayObject(_loc1_));
               this._awardsRenderers[_loc2_] = null;
               _loc2_++;
            }
            this._awardsRenderers.fixed = false;
            this._awardsRenderers.splice(0,this._awardsLength);
            this._awardsRenderers = null;
         }
      }
      
      private function validateAwardsData(param1:Vector.<AwardsItemVO>) : void
      {
         var _loc2_:AwardsItemVO = null;
         for each(_loc2_ in param1)
         {
            if(StringUtils.isNotEmpty(_loc2_.itemSource) && _loc2_.boosterVO != null)
            {
               App.utils.asserter.assert(false,"AwardsBlockVO.awardsBlock can not have itemSource and boosterVO in one time!");
               return;
            }
         }
      }
      
      public function get hasEqualPaddings() : Boolean
      {
         return this._hasEqualPaddings;
      }
      
      public function set hasEqualPaddings(param1:Boolean) : void
      {
         this._hasEqualPaddings = param1;
      }
      
      private function onLastRendererReadyHandler(param1:AwardWindowEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:ITaskAwardItemRenderer = null;
         var _loc11_:int = 0;
         this._awardsRenderers[this._awardsRenderers.length - 1].removeEventListener(AwardWindowEvent.AWARD_RENDERER_READY,this.onLastRendererReadyHandler);
         if(this._awardsLength > 0)
         {
            _loc2_ = 0;
            _loc3_ = MIN_BLOCKS_GAP;
            _loc4_ = this.getAvailableWidth() - (_loc3_ << 1);
            _loc5_ = this._awardsLength;
            _loc6_ = 0;
            while(_loc6_ < this._awardsLength)
            {
               _loc2_ += this._awardsRenderers[_loc6_].actualWidth;
               _loc11_ = _loc2_ + MIN_BLOCKS_GAP * _loc6_;
               if(_loc11_ > _loc4_)
               {
                  DebugUtils.LOG_WARNING("Width of awardsBlock is too much to be placed into award ribbon!");
                  _loc5_ = _loc6_;
                  break;
               }
               _loc6_++;
            }
            _loc7_ = (_loc4_ - _loc2_) / (_loc5_ + (!!this._hasEqualPaddings ? 1 : -1));
            if(_loc7_ > DEFAULT_BLOCKS_GAP)
            {
               _loc7_ = DEFAULT_BLOCKS_GAP;
            }
            if(_loc7_ < MIN_BLOCKS_GAP)
            {
               _loc7_ = MIN_BLOCKS_GAP;
            }
            if(this._hasEqualPaddings)
            {
               _loc3_ = _loc7_;
            }
            _loc8_ = this.getRenderersOffsetX() + _loc3_;
            _loc9_ = this.getAvailableHeight();
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc10_ = this._awardsRenderers[_loc6_];
               _loc10_.x = _loc8_;
               _loc10_.y = _loc9_ - _loc10_.height >> 1;
               _loc10_.visible = true;
               _loc8_ += _loc10_.actualWidth + _loc7_;
               _loc6_++;
            }
         }
      }
   }
}
