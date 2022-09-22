package net.wg.gui.lobby.personalMissions.components.chainsPanel
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.PERSONAL_MISSIONS_ALIASES;
   import net.wg.gui.lobby.personalMissions.components.interfaces.IChainButton;
   import net.wg.gui.lobby.personalMissions.components.interfaces.IChainsPanel;
   import net.wg.gui.lobby.personalMissions.data.ChainsPanelVO;
   import net.wg.gui.lobby.personalMissions.events.ChainEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.Button;
   import scaleform.clik.controls.ButtonGroup;
   
   public class ChainsPanel extends UIComponentEx implements IChainsPanel
   {
      
      private static const GROUP_NAME:String = "FirstCampaignScope";
      
      private static const INV_SELECTED_INDEX:String = "InvSelectedIndex";
      
      private static const CHAIN_BTN_HEIGHT:int = 69;
       
      
      private var _group:ButtonGroup;
      
      private var _list:Vector.<IChainButton>;
      
      private var _selectedChainID:int = -1;
      
      private var _data:ChainsPanelVO;
      
      public function ChainsPanel()
      {
         super();
         this._group = ButtonGroup.getGroup(GROUP_NAME,this);
      }
      
      override protected function draw() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         var _loc3_:IChainButton = null;
         super.draw();
         if(this._data != null && this._list != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               _loc1_ = this._data.chains.length;
               _loc2_ = 0;
               while(_loc2_ < _loc1_)
               {
                  this._list[_loc2_].data = this._data.chains[_loc2_];
                  _loc2_++;
               }
               invalidate(INV_SELECTED_INDEX);
            }
            if(this._group && isInvalid(INV_SELECTED_INDEX))
            {
               if(this._selectedChainID != Values.DEFAULT_INT)
               {
                  _loc3_ = IChainButton(this._list.filter(this.findSelected,this).pop());
                  this._group.setSelectedButtonByIndex(this._list.indexOf(_loc3_));
               }
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.clearList();
         this._group.dispose();
         this._group = null;
         this._data = null;
         super.onDispose();
      }
      
      public function getPanelHeight() : int
      {
         return this._list != null ? int(this._list.length * CHAIN_BTN_HEIGHT) : int(Values.ZERO);
      }
      
      public function getSelectedChainID() : int
      {
         return IChainButton(this._group.selectedButton).chainID;
      }
      
      public function init(param1:int) : void
      {
         if(this._list)
         {
            if(this._list.length == param1)
            {
               invalidateData();
               return;
            }
            this.clearList();
         }
         var _loc2_:IChainButton = null;
         var _loc3_:int = Values.ZERO;
         this._list = new Vector.<IChainButton>();
         var _loc4_:int = 0;
         while(_loc4_ < param1)
         {
            _loc2_ = App.utils.classFactory.getComponent(PERSONAL_MISSIONS_ALIASES.CHAIN_BTN_LINKACGE,IChainButton);
            if(_loc2_)
            {
               this._group.addButton(Button(_loc2_));
               _loc2_.y = _loc3_;
               this.addChild(DisplayObject(_loc2_));
               this._list.push(_loc2_);
               _loc3_ += CHAIN_BTN_HEIGHT;
            }
            _loc4_++;
         }
         this._group.addEventListener(Event.CHANGE,this.onGroupChangeHandler);
         dispatchEvent(new ChainEvent(ChainEvent.CHAIN_INIT_COMPLETED,Values.ZERO));
         invalidateData();
      }
      
      public function selectChain(param1:int) : void
      {
         if(this._selectedChainID != param1)
         {
            this._selectedChainID = param1;
            invalidate(INV_SELECTED_INDEX);
         }
      }
      
      public function update(param1:Object) : void
      {
         if(param1 != null && param1 != this._data)
         {
            this._data = ChainsPanelVO(param1);
            this.init(this._data.chains.length);
            invalidateData();
         }
      }
      
      private function clearList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:IChainButton = null;
         var _loc3_:int = 0;
         this._selectedChainID = Values.DEFAULT_INT;
         if(this._list)
         {
            _loc1_ = this._list.length;
            _loc2_ = null;
            this._group.removeEventListener(Event.CHANGE,this.onGroupChangeHandler);
            this._group.clearSelectedButton();
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               _loc2_ = this._list[_loc3_];
               this._group.removeButton(Button(_loc2_));
               this.removeChild(DisplayObject(_loc2_));
               _loc2_.dispose();
               _loc3_++;
            }
            _loc2_ = null;
            this._list.splice(0,this._list.length);
            this._list = null;
         }
      }
      
      private function findSelected(param1:IChainButton, param2:int, param3:Vector.<IChainButton>) : Boolean
      {
         return param1.chainID == this._selectedChainID;
      }
      
      private function onGroupChangeHandler(param1:Event) : void
      {
         dispatchEvent(new ChainEvent(ChainEvent.CHAIN_CHANGED,this.getSelectedChainID()));
      }
   }
}
