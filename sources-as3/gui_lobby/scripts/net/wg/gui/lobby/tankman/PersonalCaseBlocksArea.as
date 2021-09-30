package net.wg.gui.lobby.tankman
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.interfaces.IPersonalCaseBlockTitle;
   import net.wg.gui.lobby.tankman.vo.PersonalCaseBlockItemVO;
   import net.wg.gui.lobby.tankman.vo.PersonalCaseStatTitleVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class PersonalCaseBlocksArea extends UIComponentEx
   {
      
      private static const Y_START_POSITION:uint = 17;
      
      private static const PADDING_BETWEEN_BLOCKS:uint = 20;
      
      private static const PADDING_BETWEEN_BLOCK_TITLE:uint = 11;
      
      private static const VERTICAL_LINE_X:int = 341;
      
      private static const VERTICAL_LINE_HEIGHT:int = 20;
      
      private static const VERTICAL_EXTRA:int = 3;
      
      private static const STUDYING_FIELD:String = "studying";
       
      
      private var _data:Array;
      
      private var _isElementsCreated:Boolean = false;
      
      private var _paddingY:int = 17;
      
      public function PersonalCaseBlocksArea()
      {
         this._data = [];
         super();
      }
      
      override protected function onDispose() : void
      {
         this.removeElements();
         this._data.splice(0,this._data.length);
         this._data = null;
         super.onDispose();
      }
      
      public function setData(param1:Array) : void
      {
         if(!App.instance || param1 == null)
         {
            return;
         }
         this._data = param1;
         if(this._isElementsCreated)
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
         this._paddingY = Y_START_POSITION;
         var _loc1_:int = this.numChildren;
         var _loc2_:int = _loc1_ - 1;
         while(_loc2_ >= 0)
         {
            if(!(this.getChildAt(_loc2_) is Shape))
            {
               this.removeChildAt(_loc2_);
            }
            _loc2_--;
         }
         this.initializeBlocks();
      }
      
      private function initializeBlocks() : void
      {
         var _loc3_:Object = null;
         var _loc1_:int = this._data.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._data[_loc2_];
            this.createTitles(_loc3_);
            _loc2_++;
         }
         this._isElementsCreated = true;
      }
      
      private function createTitles(param1:Object) : void
      {
         var _loc2_:IPersonalCaseBlockTitle = PersonalCaseBlockTitle(this.classFactory(Linkages.PERSONAL_CASE_TITLE_BLOCK));
         var _loc3_:PersonalCaseStatTitleVO = new PersonalCaseStatTitleVO(param1);
         _loc2_.setDate(_loc3_);
         _loc2_.y = this._paddingY;
         this.addChild(DisplayObject(_loc2_));
         this._paddingY += PADDING_BETWEEN_BLOCKS;
         var _loc4_:Boolean = _loc3_.label == STUDYING_FIELD;
         if(_loc3_.isRowSeparator)
         {
            this.createVerticalLine(param1.stats.length);
         }
         this.creteRows(param1.stats,_loc3_.isRowSeparator);
      }
      
      private function createVerticalLine(param1:int = 1) : void
      {
         var _loc2_:MovieClip = this.classFactory(Linkages.VERTICAL_SPLIT_LINE);
         _loc2_.height = param1 * VERTICAL_LINE_HEIGHT + VERTICAL_EXTRA;
         _loc2_.x = VERTICAL_LINE_X;
         _loc2_.y = this._paddingY;
         this.addChild(_loc2_);
      }
      
      private function creteRows(param1:Array, param2:Boolean) : void
      {
         var _loc5_:Object = null;
         var _loc6_:PersonalCaseBlockItem = null;
         var _loc7_:PersonalCaseBlockItemVO = null;
         var _loc3_:int = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1[_loc4_];
            _loc6_ = this.classFactory(Linkages.PERSONAL_CASE_BLOCK_ITEM);
            _loc7_ = new PersonalCaseBlockItemVO(_loc5_);
            _loc6_.setData(_loc7_,param2);
            _loc6_.y = this._paddingY;
            this.addChild(_loc6_);
            this._paddingY += PADDING_BETWEEN_BLOCKS;
            _loc4_++;
         }
         this._paddingY += PADDING_BETWEEN_BLOCK_TITLE;
      }
      
      private function classFactory(param1:String) : *
      {
         return App.utils.classFactory.getComponent(param1,DisplayObject);
      }
   }
}
