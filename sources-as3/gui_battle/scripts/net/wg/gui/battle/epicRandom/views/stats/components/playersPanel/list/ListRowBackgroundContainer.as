package net.wg.gui.battle.epicRandom.views.stats.components.playersPanel.list
{
   import flash.display.MovieClip;
   import net.wg.data.constants.Linkages;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class ListRowBackgroundContainer extends MovieClip implements IDisposable
   {
      
      private static const ITEM_HEIGHT:int = 32;
       
      
      private var _listRowBackgroundItems:Vector.<ListRowBackgroundItem> = null;
      
      private var _bgState:String = "";
      
      public function ListRowBackgroundContainer()
      {
         super();
         this._listRowBackgroundItems = new Vector.<ListRowBackgroundItem>(0);
      }
      
      public final function dispose() : void
      {
         this.cleanUpContainer();
         this._listRowBackgroundItems = null;
      }
      
      public function setBackgroundRowEntries(param1:int) : void
      {
         var _loc2_:ListRowBackgroundItem = null;
         var _loc3_:int = 0;
         if(param1 != this._listRowBackgroundItems.length)
         {
            this.cleanUpContainer();
            _loc3_ = 0;
            while(_loc3_ < param1)
            {
               _loc2_ = App.utils.classFactory.getComponent(Linkages.ER_PLAYERS_PANEL_ROW_BACKGROUND_UI,ListRowBackgroundItem);
               _loc2_.y = ITEM_HEIGHT + _loc3_ * ITEM_HEIGHT;
               _loc2_.gotoAndStop(this._bgState);
               this.addChild(_loc2_);
               this._listRowBackgroundItems.push(_loc2_);
               _loc3_++;
            }
         }
      }
      
      public function setRowBackgroundEntriesState(param1:String) : void
      {
         if(param1 == this._bgState)
         {
            return;
         }
         this._bgState = param1;
         var _loc2_:int = this._listRowBackgroundItems.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this._listRowBackgroundItems[_loc3_].gotoAndStop(param1);
            _loc3_++;
         }
      }
      
      private function cleanUpContainer() : void
      {
         var _loc1_:ListRowBackgroundItem = null;
         for each(_loc1_ in this._listRowBackgroundItems)
         {
            this.removeChild(_loc1_);
            _loc1_ = null;
         }
         this._listRowBackgroundItems.splice(0,this._listRowBackgroundItems.length);
      }
      
      public function get rowHeight() : int
      {
         return this._listRowBackgroundItems.length * ITEM_HEIGHT;
      }
   }
}
