package net.wg.gui.lobby.profile.pages.awards
{
   import flash.events.Event;
   import net.wg.data.VO.AchievementProfileVO;
   import net.wg.gui.lobby.profile.components.AwardsTileListBlock;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.ILocale;
   import scaleform.clik.constants.InvalidationType;
   
   public class AwardsMainContainer extends UIComponentEx
   {
       
      
      public var blockBattleHeroes:AwardsTileListBlock;
      
      public var blockHonors:AwardsTileListBlock;
      
      public var blockEpicAwards:AwardsTileListBlock;
      
      public var blockGroupAwards:AwardsTileListBlock;
      
      public var blockCommemoratives:AwardsTileListBlock;
      
      public var blockStageAwards:AwardsTileListBlock;
      
      public var blockSpecialAwards:AwardsTileListBlock;
      
      private var _blocks:Vector.<AwardsTileListBlock>;
      
      private var _gapBetweenBlocks:uint = 20;
      
      private var _allMedalsData:Array;
      
      public function AwardsMainContainer()
      {
         super();
         addEventListener(Event.RESIZE,this.onBlockResizeHandler,false,0,true);
      }
      
      private static function applyBlockData(param1:AwardsTileListBlock, param2:Array) : Boolean
      {
         var _loc6_:Boolean = false;
         var _loc7_:AchievementProfileVO = null;
         var _loc8_:int = 0;
         var _loc9_:Boolean = false;
         var _loc3_:Array = param1.dataProvider;
         var _loc4_:int = Boolean(_loc3_) ? int(_loc3_.length) : int(0);
         var _loc5_:int = Boolean(param2) ? int(param2.length) : int(0);
         if(_loc4_ != _loc5_)
         {
            _loc6_ = true;
         }
         else
         {
            _loc8_ = 0;
            while(_loc8_ < _loc5_)
            {
               _loc7_ = AchievementProfileVO(param2[_loc8_]);
               _loc9_ = _loc7_.isEquals(_loc3_[_loc8_]);
               if(!_loc9_)
               {
                  _loc6_ = true;
                  break;
               }
               _loc8_++;
            }
         }
         if(_loc6_)
         {
            param1.dataProvider = param2;
         }
         return _loc6_;
      }
      
      override protected function configUI() : void
      {
         var _loc2_:AwardsTileListBlock = null;
         super.configUI();
         var _loc1_:ILocale = App.utils.locale;
         this.blockBattleHeroes.labelText = _loc1_.makeString(PROFILE.SECTION_AWARDS_LABELS_BATTLEHEROES);
         this.blockHonors.labelText = _loc1_.makeString(PROFILE.SECTION_AWARDS_LABELS_HONORARY);
         this.blockEpicAwards.labelText = _loc1_.makeString(PROFILE.SECTION_AWARDS_LABELS_EPIC);
         this.blockGroupAwards.labelText = _loc1_.makeString(PROFILE.SECTION_AWARDS_LABELS_GROUP);
         this.blockCommemoratives.labelText = _loc1_.makeString(PROFILE.SECTION_AWARDS_LABELS_MEMORY);
         this.blockStageAwards.labelText = _loc1_.makeString(PROFILE.SECTION_AWARDS_LABELS_STAGE);
         this.blockSpecialAwards.labelText = _loc1_.makeString(PROFILE.SECTION_AWARDS_LABELS_SPECIAL);
         this._blocks = new <AwardsTileListBlock>[this.blockBattleHeroes,this.blockHonors,this.blockEpicAwards,this.blockGroupAwards,this.blockCommemoratives,this.blockStageAwards,this.blockSpecialAwards];
         for each(_loc2_ in this._blocks)
         {
            _loc2_.visible = false;
            _loc2_.addEventListener(Event.RESIZE,this.onBlockResizeHandler,false,0,true);
         }
      }
      
      override protected function draw() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:AwardsTileListBlock = null;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            _loc1_ = this._blocks.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               if(this._allMedalsData)
               {
                  applyBlockData(this._blocks[_loc2_],this._allMedalsData[_loc2_]);
               }
               else
               {
                  applyBlockData(this._blocks[_loc2_],[]);
               }
               _loc2_++;
            }
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc3_ = this._gapBetweenBlocks;
            _loc5_ = this._blocks.length;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc4_ = this._blocks[_loc6_];
               _loc4_.y = this._gapBetweenBlocks;
               _loc4_.visible = _loc4_.dataProvider && _loc4_.dataProvider.length > 0;
               if(_loc4_.visible)
               {
                  _loc4_.y = _loc3_;
                  _loc3_ += Math.ceil(_loc4_.height + this._gapBetweenBlocks);
               }
               _loc6_++;
            }
            _height = _loc3_ - this._gapBetweenBlocks;
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:AwardsTileListBlock = null;
         while(this._blocks.length > 0)
         {
            _loc1_ = this._blocks.splice(this._blocks.length - 1,1)[0];
            _loc1_.removeEventListener(Event.RESIZE,this.onBlockResizeHandler);
            _loc1_.dispose();
            if(_loc1_.parent)
            {
               _loc1_.parent.removeChild(_loc1_);
            }
            _loc1_ = null;
         }
         this._allMedalsData = null;
         this.blockBattleHeroes = null;
         this.blockHonors = null;
         this.blockEpicAwards = null;
         this.blockGroupAwards = null;
         this.blockCommemoratives = null;
         this.blockStageAwards = null;
         this.blockSpecialAwards = null;
         this._blocks = null;
         super.onDispose();
      }
      
      protected function updateSize() : void
      {
         invalidate(InvalidationType.SIZE);
      }
      
      public function set data(param1:Array) : void
      {
         this._allMedalsData = param1;
         invalidateData();
      }
      
      public function set gapBetweenBlocks(param1:uint) : void
      {
         this._gapBetweenBlocks = param1;
         invalidateSize();
      }
      
      private function onBlockResizeHandler(param1:Event) : void
      {
         param1.stopPropagation();
         this.updateSize();
      }
      
      public function get blocks() : Vector.<AwardsTileListBlock>
      {
         return this._blocks;
      }
   }
}
