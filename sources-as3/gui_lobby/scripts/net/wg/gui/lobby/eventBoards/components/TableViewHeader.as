package net.wg.gui.lobby.eventBoards.components
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.interfaces.IUpdatableComponent;
   import net.wg.gui.lobby.eventBoards.data.EventBoardsTableViewHeaderVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class TableViewHeader extends UIComponentEx implements IUpdatableComponent
   {
      
      private static const NAME_TF_X:int = -360;
      
      private static const STATUS_TF_X:int = 10;
      
      private static const TITLE_TF_X:int = -231;
      
      private static const ICON_Y:int = 25;
      
      private static const ICON_PADDING:int = 18;
      
      private static const TITLE_INVALID:String = "titleInv";
       
      
      public var titleTF:TextField;
      
      public var levelTF:TextField;
      
      public var nameTF:TextField;
      
      public var statusTF:TextField;
      
      public var imgIcon:Image;
      
      private var _data:EventBoardsTableViewHeaderVO;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function TableViewHeader()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
      }
      
      public function update(param1:Object) : void
      {
         this._data = EventBoardsTableViewHeaderVO(param1);
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         this.levelTF.visible = false;
         this.imgIcon.visible = false;
         this.imgIcon.addEventListener(Event.CHANGE,this.onImgIconChangeHandler);
         this.statusTF.addEventListener(MouseEvent.ROLL_OVER,this.onStatusOverHandler);
         this.statusTF.addEventListener(MouseEvent.ROLL_OUT,this.onStatusOutHandler);
         this.nameTF.autoSize = TextFieldAutoSize.RIGHT;
         this.statusTF.autoSize = TextFieldAutoSize.LEFT;
         super.configUI();
      }
      
      override protected function onDispose() : void
      {
         this.statusTF.removeEventListener(MouseEvent.ROLL_OVER,this.onStatusOverHandler);
         this.statusTF.removeEventListener(MouseEvent.ROLL_OUT,this.onStatusOutHandler);
         this.titleTF = null;
         this.levelTF = null;
         this.nameTF = null;
         this.statusTF = null;
         this.imgIcon = null;
         this._data = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.titleTF.htmlText = this._data.title;
            this.nameTF.x = NAME_TF_X;
            this.nameTF.htmlText = this._data.name;
            this.statusTF.x = STATUS_TF_X;
            this.statusTF.htmlText = this._data.status;
            if(StringUtils.isNotEmpty(this._data.icon))
            {
               this.imgIcon.source = this._data.icon;
               this.imgIcon.visible = true;
            }
            this.updateLayout();
         }
         if(this._data && StringUtils.isNotEmpty(this._data.icon) && isInvalid(TITLE_INVALID))
         {
            this.updateTitle();
         }
      }
      
      private function onStatusOverHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.show(this._data.statusTooltip);
      }
      
      private function onStatusOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function updateLayout() : void
      {
         var _loc1_:int = int(this.statusTF.textWidth - this.nameTF.textWidth >> 1);
         this.nameTF.x -= _loc1_;
         this.statusTF.x -= _loc1_;
      }
      
      private function updateTitle() : void
      {
         if(StringUtils.isNotEmpty(this._data.level))
         {
            this.levelTF.htmlText = this._data.level;
            this.levelTF.visible = true;
            this.titleTF.x = Math.round(TITLE_TF_X + (this.levelTF.textWidth + this.imgIcon.width - ICON_PADDING) * 0.5);
            this.imgIcon.x = Math.round(this.titleTF.x + (this.titleTF.width - this.titleTF.textWidth) * 0.5 - this.imgIcon.width + ICON_PADDING);
            this.levelTF.x = this.imgIcon.x - this.levelTF.width + ICON_PADDING;
            this.imgIcon.y = ICON_Y - this.imgIcon.height >> 1;
         }
         else
         {
            this.levelTF.visible = false;
            this.titleTF.x = Math.round(TITLE_TF_X + this.imgIcon.width * 0.5 - ICON_PADDING);
            this.imgIcon.x = Math.round(this.titleTF.x + (this.titleTF.width - this.titleTF.textWidth) * 0.5 - this.imgIcon.width + ICON_PADDING);
            this.imgIcon.y = ICON_Y - this.imgIcon.height >> 1;
         }
      }
      
      private function onImgIconChangeHandler(param1:Event) : void
      {
         invalidate(TITLE_INVALID);
      }
   }
}
