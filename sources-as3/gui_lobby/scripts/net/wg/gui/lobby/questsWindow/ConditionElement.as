package net.wg.gui.lobby.questsWindow
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.lobby.questsWindow.components.AbstractResizableContent;
   import net.wg.gui.lobby.questsWindow.components.ResizableContainer;
   import net.wg.gui.lobby.questsWindow.data.ConditionElementVO;
   import scaleform.clik.constants.InvalidationType;
   
   public class ConditionElement extends AbstractResizableContent
   {
      
      private static const TEXT_PADDING:int = 5;
      
      private static const LEFT_POSITION:int = 140;
      
      private static const VERTICAL_PADDING:int = 10;
       
      
      public var leftLabelTF:TextField;
      
      public var rightLabelTF:TextField;
      
      public var container:ResizableContainer;
      
      public var indexTF:TextField;
      
      public var data:ConditionElementVO = null;
      
      public function ConditionElement()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.leftLabelTF = null;
         this.rightLabelTF = null;
         this.container.dispose();
         this.container = null;
         this.indexTF = null;
         if(this.data)
         {
            this.data.dispose();
            this.data = null;
         }
         super.onDispose();
      }
      
      override public function setData(param1:Object) : void
      {
         if(this.data)
         {
            this.data.dispose();
         }
         this.data = new ConditionElementVO(param1);
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.container.verticalPadding = VERTICAL_PADDING;
         this.indexTF.visible = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this.data)
            {
               if(contentAlign == TextFieldAutoSize.LEFT)
               {
                  this.leftLabelTF.htmlText = this.data.conditionType;
                  this.rightLabelTF.visible = false;
               }
               else
               {
                  this.leftLabelTF.visible = false;
                  this.rightLabelTF.htmlText = this.data.conditionType;
               }
               this.container.setData(this.data.iconElements);
               this.container.validateNow();
            }
            if(this.data.progrIndex)
            {
               this.indexTF.text = this.data.progrIndex.toString();
               this.indexTF.visible = true;
               this.rightLabelTF.x = this.leftLabelTF.x = Math.round(this.indexTF.width);
            }
            this.layoutComponents();
         }
      }
      
      private function layoutComponents() : void
      {
         if(contentAlign == TextFieldAutoSize.LEFT)
         {
            this.container.x = LEFT_POSITION;
            this.leftLabelTF.width = availableWidth - this.leftLabelTF.x;
            if(this.leftLabelTF.x + this.leftLabelTF.textWidth > this.container.x)
            {
               this.container.y = Math.round(this.leftLabelTF.height + TEXT_PADDING);
            }
         }
         var _loc1_:Number = this.container.y + this.container.height;
         var _loc2_:Number = Math.round(Math.max(this.leftLabelTF.height,this.rightLabelTF.height));
         var _loc3_:Number = Boolean(this.data) ? Number(Math.round(Math.max(_loc2_,_loc1_))) : Number(0);
         setSize(this.width,_loc3_);
         isReadyForLayout = true;
      }
   }
}
