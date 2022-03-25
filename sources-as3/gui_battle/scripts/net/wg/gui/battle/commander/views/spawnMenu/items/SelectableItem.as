package net.wg.gui.battle.commander.views.spawnMenu.items
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.commander.views.spawnMenu.events.EntryEvent;
   import net.wg.infrastructure.interfaces.entity.ISoundable;
   import net.wg.infrastructure.managers.ISoundManager;
   
   public class SelectableItem extends StagedItem implements ISoundable
   {
       
      
      public var hitBox:MovieClip = null;
      
      protected var _isFocused:Boolean = false;
      
      protected var _isFocusedVisually:Boolean = false;
      
      protected var _isSelected:Boolean = false;
      
      private var _soundMgr:ISoundManager;
      
      private var _soundType:String = "normal";
      
      public function SelectableItem()
      {
         this._soundMgr = App.soundMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this.isSoundEnabled && this._soundMgr)
         {
            this._soundMgr.addSoundsHdlrs(this);
         }
         mouseEnabled = true;
         mouseChildren = false;
         buttonMode = useHandCursor = this.isSelectable;
         addEventListener(MouseEvent.ROLL_OVER,this.onItemRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onItemRollOutHandler);
         addEventListener(MouseEvent.CLICK,this.onItemClickHandler);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onItemRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onItemRollOutHandler);
         removeEventListener(MouseEvent.CLICK,this.onItemClickHandler);
         if(this.isSoundEnabled && this._soundMgr != null)
         {
            this._soundMgr.removeSoundHdlrs(this);
            this._soundMgr = null;
         }
         this.hitBox = null;
         super.onDispose();
      }
      
      public function canPlaySound(param1:String) : Boolean
      {
         return this.isSoundEnabled;
      }
      
      public function getSoundId() : String
      {
         return Values.EMPTY_STR;
      }
      
      public function getSoundType() : String
      {
         return this.soundType;
      }
      
      protected function dispatchEntryEvent(param1:String, param2:Boolean) : void
      {
         dispatchEvent(new EntryEvent(param1,param2,this.entryType,this.itemID,this.vehicleID,this.entryID));
      }
      
      protected function get canSelect() : Boolean
      {
         return true;
      }
      
      public function get isFocused() : Boolean
      {
         return this._isFocused;
      }
      
      public function set isFocused(param1:Boolean) : void
      {
         if(this._isFocused != param1)
         {
            this._isFocused = param1;
            invalidateState();
         }
      }
      
      public function get isFocusedVisually() : Boolean
      {
         return this._isFocusedVisually;
      }
      
      public function set isFocusedVisually(param1:Boolean) : void
      {
         if(this._isFocusedVisually != param1)
         {
            this._isFocusedVisually = param1;
            invalidateState();
         }
      }
      
      public function get isSelected() : Boolean
      {
         return this._isSelected;
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         if(this._isSelected != param1)
         {
            this._isSelected = param1;
            invalidateState();
         }
      }
      
      public function get isSoundEnabled() : Boolean
      {
         return false;
      }
      
      public function get itemID() : String
      {
         return Values.EMPTY_STR;
      }
      
      [Inspectable(defaultValue="normal",type="String")]
      public function get soundType() : String
      {
         return this._soundType;
      }
      
      public function set soundType(param1:String) : void
      {
         if(param1 && param1 != this._soundType)
         {
            this._soundType = param1;
         }
      }
      
      public function get entryType() : int
      {
         App.utils.asserter.assert(false,"not implemented entryType in \'" + this + "\'!");
         return 0;
      }
      
      public function get vehicleID() : Number
      {
         return 0;
      }
      
      public function get entryID() : String
      {
         return null;
      }
      
      public function get isSelectable() : Boolean
      {
         return false;
      }
      
      private function onItemRollOverHandler(param1:MouseEvent) : void
      {
         if(this.isSelectable)
         {
            this.dispatchEntryEvent(EntryEvent.FOCUS,true);
         }
      }
      
      private function onItemRollOutHandler(param1:MouseEvent) : void
      {
         if(this.isSelectable)
         {
            this.dispatchEntryEvent(EntryEvent.FOCUS,false);
         }
      }
      
      private function onItemClickHandler(param1:MouseEvent) : void
      {
         if(this.isSelectable && App.utils.commons.isLeftButton(param1) && this.canSelect)
         {
            this.dispatchEntryEvent(EntryEvent.SELECT,true);
         }
      }
   }
}
