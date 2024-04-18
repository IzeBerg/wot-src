package net.wg.gui.crewOperations
{
   import flash.display.Graphics;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.interfaces.ITutorialCustomComponent;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.ListItemRenderer;
   import scaleform.clik.events.ButtonEvent;
   
   public class CrewOperationsIRenderer extends ListItemRenderer implements IUpdatable, ITutorialCustomComponent
   {
      
      private static const OFFSET_BETWEEN_TEXT_AND_BUTTON:uint = 16;
       
      
      public var iconLoader:UILoaderAlt;
      
      public var title:TextField;
      
      public var description:TextField;
      
      public var footer:CrewOperationsIRFooter;
      
      private var _crewOperationInfoVO:CrewOperationInfoVO;
      
      private var _myHitArea:MovieClip;
      
      public function CrewOperationsIRenderer()
      {
         this._myHitArea = new MovieClip();
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.description.mouseEnabled = false;
         buttonMode = false;
         mouseChildren = true;
         this.footer.button.addEventListener(ButtonEvent.CLICK,this.onFooterButtonClickHandler,false,0,true);
         addChildAt(this._myHitArea,0);
         hitArea = this._myHitArea;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Graphics = null;
         super.draw();
         if(this._crewOperationInfoVO && isInvalid(InvalidationType.DATA))
         {
            this.title.text = this._crewOperationInfoVO.title;
            this.description.text = this._crewOperationInfoVO.description;
            App.utils.commons.updateTextFieldSize(this.description,false);
            this.iconLoader.source = this._crewOperationInfoVO.iconPath;
            this.footer.data = this._crewOperationInfoVO;
            this.footer.validateNow();
            this.footer.y = this.description.y + this.description.height + OFFSET_BETWEEN_TEXT_AND_BUTTON - this.footer.button.y;
            _height = this.footer.y + this.footer.height;
            this._myHitArea.mouseEnabled = false;
            _loc1_ = this._myHitArea.graphics;
            _loc1_.clear();
            _loc1_.beginFill(0,0);
            _loc1_.drawRect(0,0,_width,_height);
            _loc1_.endFill();
         }
      }
      
      override public function get scaleY() : Number
      {
         return _height / actualHeight;
      }
      
      override protected function onDispose() : void
      {
         this._crewOperationInfoVO = null;
         this.footer.button.removeEventListener(ButtonEvent.CLICK,this.onFooterButtonClickHandler,false);
         this.footer.dispose();
         this.footer = null;
         this.description = null;
         this.title = null;
         this.iconLoader.dispose();
         this.iconLoader = null;
         this._myHitArea.stop();
         removeChild(this._myHitArea);
         this._myHitArea = null;
         super.onDispose();
      }
      
      public function update(param1:Object) : void
      {
      }
      
      override public function setData(param1:Object) : void
      {
         this._crewOperationInfoVO = CrewOperationInfoVO(param1);
         invalidateData();
      }
      
      override public function getData() : Object
      {
         return this._crewOperationInfoVO;
      }
      
      private function onFooterButtonClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new CrewOperationEvent(CrewOperationEvent.OPERATION_CHANGED,this._crewOperationInfoVO.id,true));
      }
      
      public function getTutorialDescriptionName() : String
      {
         return "";
      }
      
      public function needPreventInnerEvents() : Boolean
      {
         return false;
      }
      
      public function generatedUnstoppableEvents() : Boolean
      {
         return false;
      }
   }
}
