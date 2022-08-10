package net.wg.gui.lobby.training
{
   import flash.display.InteractiveObject;
   import flash.events.KeyboardEvent;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import net.wg.data.VO.TrainingFormInfoVO;
   import net.wg.data.VO.TrainingFormVO;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.icons.BattleTypeIcon;
   import net.wg.gui.events.TrainingEvent;
   import net.wg.infrastructure.base.meta.ITrainingFormMeta;
   import net.wg.infrastructure.base.meta.impl.TrainingFormMeta;
   import net.wg.utils.IGameInputManager;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.utils.Constraints;
   
   public class TrainingForm extends TrainingFormMeta implements ITrainingFormMeta
   {
      
      private static const ASSERT_MSG_LIST_NAME:String = "_data.listData";
      
      private static const SUB_VIEW_MARGIN:Number = 120;
       
      
      public var list:ScrollingListEx;
      
      public var sb:ScrollBar;
      
      public var battleIcon:BattleTypeIcon;
      
      public var createButon:SoundButtonEx;
      
      public var leaveButton:SoundButtonEx;
      
      public var titleField:TextField;
      
      public var descriptionLabel:TextField;
      
      public var listTitle:TextField;
      
      public var ownerTitle:TextField;
      
      public var playersTitle:TextField;
      
      public var roomsLabel:TextField;
      
      public var playersLabel:TextField;
      
      private var _data:TrainingFormVO;
      
      private var _roomsLabelText:String = "";
      
      private var _playersLabelText:String = "";
      
      private var _myWidth:Number = 0;
      
      private var _gameInputMgr:IGameInputManager;
      
      public function TrainingForm()
      {
         this._gameInputMgr = App.gameInputMgr;
         super();
      }
      
      override public final function setViewSize(param1:Number, param2:Number) : void
      {
         this._myWidth = param1;
         invalidateSize();
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         this.setViewSize(param1,param2);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.updateStage(App.appWidth,App.appHeight);
         this.battleIcon.type = BattleTypeIcon.TYPE_TRAINING;
         this.ownerTitle.text = MENU.TRAINING_OWNERTITLE;
         this.playersTitle.text = MENU.TRAINING_PLAYERSTITLE;
         this.listTitle.text = MENU.TRAINING_LISTTITLE;
         constraints = new Constraints(this,ConstrainMode.COUNTER_SCALE);
         this.createButon.addEventListener(ButtonEvent.CLICK,this.onCreateButtonClickHandler);
         this.leaveButton.addEventListener(ButtonEvent.CLICK,this.onLeaveButtonClickHandler);
         this.leaveButton.label = MENU.TRAINING_LEAVEBUTTON;
         addEventListener(TrainingEvent.OPEN_TRAINING_ROOM,this.onOpenTrainingRoomHandler);
         this._gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape,true);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            x = this._myWidth - _originalWidth >> 1;
            y = -SUB_VIEW_MARGIN;
         }
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this._roomsLabelText = this._data.roomsLabel;
            this._playersLabelText = this._data.playersLabel;
            this.roomsLabel.htmlText = this._roomsLabelText;
            this.playersLabel.htmlText = this._playersLabelText;
         }
      }
      
      override protected function onDispose() : void
      {
         this.createButon.removeEventListener(ButtonEvent.CLICK,this.onCreateButtonClickHandler);
         this.leaveButton.removeEventListener(ButtonEvent.CLICK,this.onLeaveButtonClickHandler);
         this._gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape);
         removeEventListener(TrainingEvent.OPEN_TRAINING_ROOM,this.onOpenTrainingRoomHandler);
         this._data = null;
         this.sb.dispose();
         this.sb = null;
         if(this.list.dataProvider != null)
         {
            this.list.dataProvider.cleanUp();
            this.list.dataProvider = null;
         }
         this.list.dispose();
         this.list = null;
         this.battleIcon.dispose();
         this.battleIcon = null;
         this.createButon.dispose();
         this.createButon = null;
         this.leaveButton.dispose();
         this.leaveButton = null;
         this.titleField = null;
         this.descriptionLabel = null;
         this.listTitle = null;
         this.ownerTitle = null;
         this.playersTitle = null;
         this.roomsLabel = null;
         this.playersLabel = null;
         this._gameInputMgr = null;
         super.onDispose();
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         setFocus(this.createButon);
      }
      
      override protected function setInfo(param1:TrainingFormInfoVO) : void
      {
         this.titleField.text = param1.title;
         this.descriptionLabel.text = param1.descr;
         this.battleIcon.type = param1.battleTypeID;
      }
      
      override protected function setList(param1:TrainingFormVO) : void
      {
         this._data = param1;
         assertNotNull(this._data.listData,ASSERT_MSG_LIST_NAME + Errors.CANT_NULL);
         this.list.dataProvider = this._data.listData;
         invalidateData();
      }
      
      private function onOpenTrainingRoomHandler(param1:TrainingEvent) : void
      {
         joinTrainingRequestS(param1.initObj.id);
      }
      
      private function onCreateButtonClickHandler(param1:ButtonEvent) : void
      {
         createTrainingRequestS();
      }
      
      private function onLeaveButtonClickHandler(param1:ButtonEvent) : void
      {
         onLeaveS();
      }
      
      private function handleEscape(param1:InputEvent) : void
      {
         onEscapeS();
      }
   }
}
