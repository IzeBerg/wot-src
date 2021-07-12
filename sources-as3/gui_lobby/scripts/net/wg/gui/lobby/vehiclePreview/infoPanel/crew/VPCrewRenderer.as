package net.wg.gui.lobby.vehiclePreview.infoPanel.crew
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.lobby.components.SmallSkillsList;
   import net.wg.gui.lobby.vehiclePreview.VehiclePreviewEvent;
   import scaleform.clik.constants.InvalidationType;
   
   public class VPCrewRenderer extends SoundListItemRenderer
   {
       
      
      public var icon:Image;
      
      public var nameTF:TextField;
      
      public var skills:SmallSkillsList = null;
      
      private var _rendererData:VPCrewRendererVO;
      
      private var _content:Sprite;
      
      public function VPCrewRenderer()
      {
         super();
         this.skills.showBuyAnimation = false;
         constraintsDisabled = true;
         preventAutosizing = true;
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         if(param1 != null)
         {
            this._rendererData = VPCrewRendererVO(param1);
            if(param1.tankman)
            {
               this.skills.updateSkills(param1.tankman);
               this.skills.visible = true;
            }
            else
            {
               this.skills.visible = false;
            }
            invalidateData();
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._rendererData && isInvalid(InvalidationType.DATA))
         {
            this.icon.source = this._rendererData.icon;
            this.nameTF.htmlText = this._rendererData.name;
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            if(this.skills.visible)
            {
               this._content.y = height - this._content.height >> 1;
            }
            else
            {
               this._content.y = height - this.nameTF.height >> 1;
            }
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._content = new Sprite();
         this._content.name = "content";
         this._content.addChild(this.nameTF);
         this._content.addChild(this.skills);
         addChild(this._content);
         this.nameTF.autoSize = TextFieldAutoSize.LEFT;
         buttonMode = false;
         enabled = false;
         mouseEnabledOnDisabled = true;
      }
      
      override protected function onDispose() : void
      {
         this.skills.dispose();
         this.skills = null;
         this.icon.dispose();
         this.icon = null;
         this.nameTF = null;
         this._rendererData = null;
         while(this._content.numChildren)
         {
            this._content.removeChildAt(0);
         }
         this._content = null;
         super.onDispose();
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         super.handleMouseRollOver(param1);
         if(this._rendererData)
         {
            dispatchEvent(new VehiclePreviewEvent(VehiclePreviewEvent.SHOW_TOOLTIP,this._rendererData));
         }
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         super.handleMouseRollOut(param1);
         App.toolTipMgr.hide();
      }
   }
}
