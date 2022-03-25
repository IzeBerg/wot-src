package net.wg.gui.battle.commander.views.spawnMenu.map.entries
{
   import net.wg.gui.battle.commander.views.spawnMenu.items.SelectableItem;
   import net.wg.gui.battle.commander.views.spawnMenu.map.VO.BaseEntryVO;
   import net.wg.gui.battle.commander.views.spawnMenu.map.entries.components.VisionRadius;
   
   public class BaseEntry extends SelectableItem
   {
       
      
      protected var _data:BaseEntryVO = null;
      
      public function BaseEntry()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this._data = null;
         super.onDispose();
      }
      
      public function setData(param1:BaseEntryVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      public function setRadiusScaleFactor(param1:Number) : void
      {
         var _loc2_:VisionRadius = this.visionRadius;
         if(_loc2_)
         {
            _loc2_.setScale(param1);
         }
      }
      
      override public function get entryID() : String
      {
         return this.data.entryID;
      }
      
      public function get visionRadius() : VisionRadius
      {
         return null;
      }
      
      override public function get entryType() : int
      {
         return this.data.entryType;
      }
      
      public function get data() : BaseEntryVO
      {
         return this._data;
      }
      
      override public function get isSelectable() : Boolean
      {
         return true;
      }
   }
}
