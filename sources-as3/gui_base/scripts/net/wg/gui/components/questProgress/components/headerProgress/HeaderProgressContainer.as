package net.wg.gui.components.questProgress.components.headerProgress
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import net.wg.data.constants.generated.QUEST_PROGRESS_BASE;
   import net.wg.gui.components.questProgress.QuestProgressConstsBase;
   import net.wg.gui.components.questProgress.interfaces.components.IHeaderProgressItem;
   import net.wg.gui.components.questProgress.interfaces.data.IHeaderProgressData;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class HeaderProgressContainer extends Sprite implements IDisposable
   {
      
      private static const MAIN_CONDITIONS_WIDTH:int = 442;
      
      private static const ADD_CONDITIONS_WIDTH:int = 313;
       
      
      private var _headerConditions:Vector.<IHeaderProgressItem> = null;
      
      private var _startXMainType:int = 0;
      
      private var _startXAddType:int = 0;
      
      private var _disposed:Boolean = false;
      
      public function HeaderProgressContainer()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.cleanHeaders(this._headerConditions);
         this._headerConditions = null;
      }
      
      public function setData(param1:Vector.<IHeaderProgressData>, param2:int, param3:int) : void
      {
         this._startXMainType = param2;
         this._startXAddType = param3;
         this.cleanHeaders(this._headerConditions);
         this._headerConditions = new Vector.<IHeaderProgressItem>(0);
         this.createHeaders(this._headerConditions,param1);
      }
      
      public function updateHeaderProgress(param1:Vector.<IHeaderProgressData>) : void
      {
         var _loc3_:IHeaderProgressData = null;
         var _loc2_:IHeaderProgressItem = null;
         for each(_loc3_ in param1)
         {
            _loc2_ = this.getItemByOrderType(_loc3_.orderType);
            if(_loc2_)
            {
               _loc2_.update(_loc3_);
            }
         }
      }
      
      private function cleanHeaders(param1:Vector.<IHeaderProgressItem>) : void
      {
         var _loc2_:IUIComponentEx = null;
         if(param1 != null)
         {
            for each(_loc2_ in param1)
            {
               this.removeChild(DisplayObject(_loc2_));
               _loc2_.dispose();
            }
            param1.splice(0,param1.length);
            param1 = null;
         }
      }
      
      private function createHeaders(param1:Vector.<IHeaderProgressItem>, param2:Vector.<IHeaderProgressData>) : void
      {
         var _loc3_:String = null;
         var _loc4_:IHeaderProgressItem = null;
         var _loc5_:int = 0;
         var _loc6_:IHeaderProgressData = null;
         for each(_loc6_ in param2)
         {
            _loc3_ = QuestProgressConstsBase.getHeaderItemLinkage(_loc6_.progressType);
            _loc4_ = App.utils.classFactory.getComponent(_loc3_,IHeaderProgressItem);
            if(_loc4_)
            {
               _loc5_ = _loc6_.orderType == QUEST_PROGRESS_BASE.MAIN_ORDER_TYPE ? int(MAIN_CONDITIONS_WIDTH) : int(ADD_CONDITIONS_WIDTH);
               _loc4_.setData(_loc6_,_loc5_);
               _loc4_.x = _loc4_.orderType == QUEST_PROGRESS_BASE.MAIN_ORDER_TYPE ? Number(this._startXMainType) : Number(this._startXAddType);
               param1.push(_loc4_);
               this.addChild(DisplayObject(_loc4_));
            }
         }
      }
      
      private function getItemByOrderType(param1:String) : IHeaderProgressItem
      {
         var _loc2_:IHeaderProgressItem = null;
         for each(_loc2_ in this._headerConditions)
         {
            if(_loc2_.orderType == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
