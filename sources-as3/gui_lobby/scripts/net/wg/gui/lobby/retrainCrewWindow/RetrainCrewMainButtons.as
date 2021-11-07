package net.wg.gui.lobby.retrainCrewWindow
{
   import flash.events.Event;
   import net.wg.data.constants.SoundTypes;
   import net.wg.gui.components.controls.TankmanTrainingSmallButton;
   import net.wg.gui.interfaces.ISoundButton;
   import net.wg.gui.lobby.tankman.vo.RetrainButtonVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.controls.ButtonGroup;
   import scaleform.clik.events.IndexEvent;
   
   public class RetrainCrewMainButtons extends UIComponentEx
   {
      
      private static const GROUP_NAME:String = "crewRetrainingGroup";
      
      private static const INVALIDATE_BUTTONS:String = "invalidateButtons";
       
      
      public var academyBtn:TankmanTrainingSmallButton;
      
      public var schoolBtn:TankmanTrainingSmallButton;
      
      public var freeBtn:TankmanTrainingSmallButton;
      
      private var _btnGroup:ButtonGroup;
      
      private var _selectedId:int = 0;
      
      private var _retrainingButtons:Vector.<TankmanTrainingSmallButton>;
      
      public function RetrainCrewMainButtons()
      {
         super();
         this._retrainingButtons = new <TankmanTrainingSmallButton>[this.freeBtn,this.schoolBtn,this.academyBtn];
      }
      
      override protected function configUI() : void
      {
         var _loc1_:TankmanTrainingSmallButton = null;
         super.configUI();
         this._btnGroup = new ButtonGroup(GROUP_NAME,this);
         this._btnGroup.addButton(this.freeBtn);
         this._btnGroup.addButton(this.schoolBtn);
         this._btnGroup.addButton(this.academyBtn);
         this._btnGroup.addEventListener(Event.CHANGE,this.onBtnGroupChangeHandler,false,0,true);
         var _loc2_:int = this._retrainingButtons.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = this._retrainingButtons[_loc3_];
            _loc1_.groupName = GROUP_NAME;
            _loc1_.toggle = true;
            _loc1_.soundType = SoundTypes.RNDR_NORMAL;
            _loc1_.allowDeselect = false;
            _loc3_++;
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALIDATE_BUTTONS))
         {
            this.autoSelectRetrainingButtons();
            this.onBtnGroupChangeHandler();
         }
      }
      
      override protected function onDispose() : void
      {
         this._btnGroup.removeEventListener(Event.CHANGE,this.onBtnGroupChangeHandler);
         this._btnGroup.dispose();
         this._btnGroup = null;
         this.academyBtn.dispose();
         this.academyBtn = null;
         this.schoolBtn.dispose();
         this.schoolBtn = null;
         this.freeBtn.dispose();
         this.freeBtn = null;
         this._retrainingButtons.splice(0,this._retrainingButtons.length);
         this._retrainingButtons = null;
         super.onDispose();
      }
      
      public function updateRetrainingButtons(param1:Vector.<RetrainButtonVO>) : void
      {
         var _loc2_:Number = this._retrainingButtons.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this._retrainingButtons[_loc3_].setData(param1[_loc3_]);
            _loc3_++;
         }
         invalidate(INVALIDATE_BUTTONS);
      }
      
      private function autoSelectRetrainingButtons() : void
      {
         var _loc1_:ISoundButton = null;
         var _loc2_:int = this._retrainingButtons.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = this._retrainingButtons[_loc3_];
            if(_loc1_.enabled)
            {
               _loc1_.selected = true;
               return;
            }
            _loc3_++;
         }
      }
      
      public function get selectedId() : int
      {
         return this._selectedId;
      }
      
      private function onBtnGroupChangeHandler(param1:Event = null) : void
      {
         this._selectedId = this._btnGroup.selectedIndex;
         dispatchEvent(new IndexEvent(IndexEvent.INDEX_CHANGE,false,true,this._selectedId));
      }
   }
}
