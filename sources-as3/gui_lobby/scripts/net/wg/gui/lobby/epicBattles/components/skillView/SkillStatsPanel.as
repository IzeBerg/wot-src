package net.wg.gui.lobby.epicBattles.components.skillView
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.VO.PaddingVO;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.BLOCKS_TOOLTIP_TYPES;
   import net.wg.gui.components.tooltips.inblocks.data.BlockDataItemVO;
   import net.wg.gui.components.tooltips.inblocks.data.BuildUpBlockVO;
   import net.wg.gui.lobby.epicBattles.interfaces.skillView.ISkillParameterBlock;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class SkillStatsPanel extends UIComponentEx
   {
      
      private static const STARTING_TOP_OFFSET:int = 10;
       
      
      public var content:MovieClip = null;
      
      public var title:TextField = null;
      
      private var _blocks:Vector.<ISkillParameterBlock>;
      
      private var _blockData:BuildUpBlockVO;
      
      public function SkillStatsPanel()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.cleanUpBlocks();
         this._blocks.fixed = false;
         this._blocks.splice(0,this._blocks.length);
         this._blocks = null;
         this.clearData();
         this.content = null;
         this.title = null;
         super.onDispose();
      }
      
      public function setBlock(param1:BlockDataItemVO) : void
      {
         this.cleanUpBlocks();
         this._blockData = new BuildUpBlockVO(param1.data);
         this.buildBlocks();
      }
      
      public function setHtmlText(param1:String) : void
      {
         this.title.htmlText = param1;
      }
      
      private function buildBlocks() : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:PaddingVO = null;
         var _loc5_:BlockDataItemVO = null;
         var _loc6_:DisplayObject = null;
         var _loc10_:Boolean = false;
         var _loc11_:String = null;
         var _loc12_:Class = null;
         var _loc13_:ISkillParameterBlock = null;
         var _loc1_:int = this._blockData.gap;
         var _loc2_:Number = STARTING_TOP_OFFSET;
         var _loc7_:Vector.<BlockDataItemVO> = this._blockData.blocksData;
         var _loc8_:int = _loc7_.length;
         this._blocks = new Vector.<ISkillParameterBlock>(_loc8_,true);
         var _loc9_:int = 0;
         while(_loc9_ < _loc8_)
         {
            _loc5_ = _loc7_[_loc9_];
            _loc10_ = _loc5_.linkage == BLOCKS_TOOLTIP_TYPES.TOOLTIP_TEXT_PARAMETER_BLOCK_LINKAGE;
            _loc11_ = !!_loc10_ ? Linkages.TEXT_PARAMETER_BLOCK_UI : Linkages.DELTA_STATUS_INDICATOR_UI;
            _loc12_ = !!_loc10_ ? TextParameterBlock : StatusDeltaParameterBlock;
            _loc13_ = App.utils.classFactory.getComponent(_loc11_,_loc12_);
            this._blocks[_loc9_] = _loc13_;
            _loc13_.setBlockData(_loc5_.data);
            _loc6_ = _loc13_.getDisplayObject();
            _loc4_ = _loc5_.padding;
            _loc3_ = _loc4_ != null;
            _loc2_ += (!!_loc3_ ? _loc4_.top : 0) + (_loc9_ > 0 ? _loc1_ : 0);
            _loc6_.x = !!_loc3_ ? Number(_loc4_.left) : Number(0);
            _loc6_.y = _loc2_ | 0;
            _loc2_ += _loc13_.getHeight() + (!!_loc3_ ? _loc4_.bottom : 0);
            this.content.addChild(_loc6_);
            _loc9_++;
         }
      }
      
      private function clearData() : void
      {
         if(this._blockData != null)
         {
            this._blockData.dispose();
            this._blockData = null;
         }
      }
      
      private function cleanUpBlocks() : void
      {
         var _loc1_:DisplayObject = null;
         var _loc2_:ISkillParameterBlock = null;
         for each(_loc2_ in this._blocks)
         {
            _loc1_ = _loc2_.getDisplayObject();
            this.content.removeChild(_loc1_);
            _loc2_.dispose();
            _loc2_ = null;
         }
      }
   }
}
