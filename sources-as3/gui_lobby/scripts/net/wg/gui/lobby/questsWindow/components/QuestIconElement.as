package net.wg.gui.lobby.questsWindow.components
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.lobby.questsWindow.data.QuestIconElementVO;
   import scaleform.clik.constants.InvalidationType;
   
   public class QuestIconElement extends AbstractResizableContent
   {
      
      public static const TEXT_PADDING:int = 5;
       
      
      public var icon:UILoaderAlt;
      
      public var labelTF:TextField;
      
      public var counterTF:TextField = null;
      
      private var dataVO:QuestIconElementVO = null;
      
      public function QuestIconElement()
      {
         super();
      }
      
      private static function hideTooltip(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.counterTF.autoSize = TextFieldAutoSize.LEFT;
         this.icon.addEventListener(MouseEvent.ROLL_OUT,hideTooltip);
         this.icon.addEventListener(MouseEvent.CLICK,hideTooltip);
         this.icon.addEventListener(MouseEvent.ROLL_OVER,this.showTooltip);
      }
      
      override protected function onDispose() : void
      {
         this.icon.removeEventListener(MouseEvent.ROLL_OUT,hideTooltip);
         this.icon.removeEventListener(MouseEvent.CLICK,hideTooltip);
         this.icon.removeEventListener(MouseEvent.ROLL_OVER,this.showTooltip);
         this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.onIconLoadedHandler);
         this.icon.dispose();
         this.labelTF = null;
         this.counterTF = null;
         if(this.dataVO)
         {
            this.dataVO.dispose();
            this.dataVO = null;
         }
         super.onDispose();
      }
      
      override public function setData(param1:Object) : void
      {
         if(this.dataVO)
         {
            this.dataVO.dispose();
         }
         this.dataVO = new QuestIconElementVO(param1);
         invalidateData();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.DATA) && this.dataVO)
         {
            this.icon.source = this.dataVO.icon;
            this.icon.autoSize = this.dataVO.iconAutoSize;
            this.counterTF.htmlText = this.dataVO.counter;
            this.labelTF.htmlText = this.dataVO.label;
            _loc1_ = Math.round(this.labelTF.height);
            _loc2_ = 0;
            if(this.dataVO.counter)
            {
               _loc2_ = this.counterTF.textWidth + TEXT_PADDING;
            }
            if(this.dataVO.icon)
            {
               this.icon.x = _loc2_;
               _loc2_ += this.icon.width + TEXT_PADDING;
            }
            this.labelTF.x = _loc2_;
            setSize(this.width,_loc1_);
            if(!this.dataVO.iconAutoSize)
            {
               this.icon.addEventListener(UILoaderEvent.COMPLETE,this.onIconLoadedHandler);
            }
            else
            {
               this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.onIconLoadedHandler);
            }
         }
      }
      
      private function showTooltip(param1:MouseEvent) : void
      {
         if(this.dataVO.dataType && this.dataVO.dataName && this.dataVO.dataBlock)
         {
            App.toolTipMgr.showSpecial(this.dataVO.dataType,null,this.dataVO.dataBlock,this.dataVO.dataName);
         }
         else if(this.dataVO.dataType)
         {
            App.toolTipMgr.showComplex(this.dataVO.dataType);
         }
      }
      
      private function onIconLoadedHandler(param1:UILoaderEvent) : void
      {
         this.icon.y = _height - this.icon.height >> 1;
      }
   }
}
