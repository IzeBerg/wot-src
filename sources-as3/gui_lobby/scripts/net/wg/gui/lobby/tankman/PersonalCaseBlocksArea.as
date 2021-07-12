package net.wg.gui.lobby.tankman
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.tooltips.VO.PersonalCaseBlockItemVO;
   import net.wg.gui.interfaces.IPersonalCaseBlockTitle;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class PersonalCaseBlocksArea extends UIComponentEx
   {
      
      private static const Y_START_POSITION:uint = 17;
      
      private static const PADDING_BETWEEN_BLOCKS:uint = 20;
      
      private static const PADDING_BETWEEN_BLOCK_TITLE:uint = 11;
      
      private static const VERTICAL_LINE_X:int = 341;
      
      private static const VERTICAL_LINE_Y:int = 112;
      
      private static const VERTICAL_LINE_HEIGHT:int = 44;
      
      private static const STUDYING_FIELD:String = "studying";
       
      
      private var data:Array;
      
      private var isElementsCreated:Boolean = false;
      
      private var paddingY:int = 17;
      
      public function PersonalCaseBlocksArea()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.removeElements();
         super.onDispose();
      }
      
      public function setData(param1:Array) : void
      {
         if(!App.instance || param1 == null)
         {
            return;
         }
         this.data = param1;
         if(this.isElementsCreated)
         {
            this.updateBlocks();
         }
         else
         {
            this.initializeBlocks();
         }
      }
      
      private function removeElements() : void
      {
         var _loc1_:uint = this.numChildren;
         var _loc2_:int = _loc1_ - 1;
         while(_loc2_ >= 0)
         {
            if(this.getChildAt(_loc2_) is IDisposable)
            {
               IDisposable(this.getChildAt(_loc2_)).dispose();
            }
            this.removeChildAt(_loc2_);
            _loc2_--;
         }
      }
      
      private function updateBlocks() : void
      {
         var _loc3_:Object = null;
         this.paddingY = Y_START_POSITION;
         var _loc1_:int = this.numChildren;
         var _loc2_:int = _loc1_ - 1;
         while(_loc2_ >= 0)
         {
            _loc3_ = this.getChildAt(_loc2_);
            if(this.getChildAt(_loc2_) is Shape == false)
            {
               this.removeChildAt(_loc2_);
            }
            _loc2_--;
         }
         this.initializeBlocks();
      }
      
      private function initializeBlocks() : void
      {
         var _loc2_:Object = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.data.length)
         {
            _loc2_ = this.data[_loc1_];
            this.createTitles(_loc2_);
            _loc1_++;
         }
         this.isElementsCreated = true;
      }
      
      private function createTitles(param1:Object) : void
      {
         var _loc2_:IPersonalCaseBlockTitle = PersonalCaseBlockTitle(this.classFactory(Linkages.PERSONAL_CASE_TITLE_BLOCK));
         _loc2_.setLeftText(MENU.profile_stats_blocks(param1.label));
         var _loc3_:Boolean = param1.label == STUDYING_FIELD;
         var _loc4_:Boolean = false;
         if(_loc3_)
         {
            _loc4_ = param1.isPremium;
            _loc2_.premiumVehicle(param1.isPremium);
            _loc2_.setRightText(param1.secondLabel);
         }
         _loc2_.y = this.paddingY;
         this.addChild(DisplayObject(_loc2_));
         this.paddingY += PADDING_BETWEEN_BLOCKS;
         this.creteRows(param1.stats,_loc3_,_loc4_);
         if(param1.hasOwnProperty("secondLabel") && param1.secondLabel != Values.EMPTY_STR)
         {
            this.createVerticalLine();
         }
      }
      
      private function createVerticalLine() : void
      {
         var _loc1_:MovieClip = this.classFactory(Linkages.VERTICAL_SPLIT_LINE);
         _loc1_.height = VERTICAL_LINE_HEIGHT;
         _loc1_.x = VERTICAL_LINE_X;
         _loc1_.y = VERTICAL_LINE_Y;
         this.addChild(_loc1_);
      }
      
      private function creteRows(param1:Array, param2:Boolean, param3:Boolean) : void
      {
         var _loc5_:Object = null;
         var _loc6_:PersonalCaseBlockItem = null;
         var _loc7_:PersonalCaseBlockItemVO = null;
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = param1[_loc4_];
            _loc6_ = this.classFactory(Linkages.PERSONAL_CASE_BLOCK_ITEM);
            _loc7_ = new PersonalCaseBlockItemVO(_loc5_);
            _loc6_.useBlocks(param2,param3);
            _loc6_.setData(_loc7_);
            _loc6_.y = this.paddingY;
            this.addChild(_loc6_);
            this.paddingY += PADDING_BETWEEN_BLOCKS;
            _loc4_++;
         }
         this.paddingY += PADDING_BETWEEN_BLOCK_TITLE;
      }
      
      private function classFactory(param1:String) : *
      {
         return App.utils.classFactory.getComponent(param1,DisplayObject);
      }
   }
}
