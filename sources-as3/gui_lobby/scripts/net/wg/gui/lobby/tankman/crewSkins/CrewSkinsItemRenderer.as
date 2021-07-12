package net.wg.gui.lobby.tankman.crewSkins
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.tankman.crewSkins.model.CrewSkinVO;
   import scaleform.clik.constants.InvalidationType;
   
   public class CrewSkinsItemRenderer extends SoundListItemRenderer
   {
       
      
      public var grade:MovieClip;
      
      public var icon:UILoaderAlt;
      
      public var soundIcon:Sprite;
      
      public var title:TextField;
      
      public var nation:UILoaderAlt;
      
      public var role:UILoaderAlt;
      
      public var mcSize:Sprite;
      
      protected var _skinModel:CrewSkinVO;
      
      public function CrewSkinsItemRenderer()
      {
         super();
         soundType = SoundTypes.RNDR_NORMAL;
         preventAutosizing = true;
      }
      
      override public function get width() : Number
      {
         return Boolean(this.mcSize) ? Number(this.mcSize.width) : Number(super.width);
      }
      
      override public function get height() : Number
      {
         return Boolean(this.mcSize) ? Number(this.mcSize.height) : Number(super.height);
      }
      
      public function hideTooltip() : void
      {
         App.toolTipMgr.hide();
      }
      
      public function showTooltip() : void
      {
         App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.CREW_SKIN,null,this._skinModel.id);
      }
      
      override public function setData(param1:Object) : void
      {
         if(param1 == null)
         {
            this.visible = false;
            return;
         }
         this.visible = true;
         super.setData(param1);
         this._skinModel = param1 as CrewSkinVO;
         App.utils.asserter.assertNotNull(this._skinModel,"_skinModel" + Errors.CANT_NULL);
         invalidate(InvalidationType.DATA);
      }
      
      override protected function onDispose() : void
      {
         App.utils.scheduler.cancelTask(this.showTooltip);
         removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
         this.grade = null;
         this.icon.dispose();
         this.icon = null;
         this.soundIcon = null;
         this.title = null;
         this.nation.dispose();
         this.nation = null;
         this.role.dispose();
         this.role = null;
         this.mcSize = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         buttonMode = true;
         super.configUI();
         addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(_data != null && isInvalid(InvalidationType.DATA))
         {
            this.icon.source = this._skinModel.iconID;
            this.soundIcon.visible = this._skinModel.soundSetID.length > 1;
            this.nation.visible = this._skinModel.nationFlagIconID.length > 1;
            this.nation.source = this._skinModel.nationFlagIconID;
            this.role.visible = this._skinModel.roleIconID.length > 1;
            this.role.source = this._skinModel.roleIconID;
            this.grade.gotoAndStop(this._skinModel.rarity);
         }
      }
      
      protected function onMouseRollOutHandler(param1:MouseEvent = null) : void
      {
         this.hideTooltip();
      }
      
      protected function onMouseRollOverHandler(param1:MouseEvent = null) : void
      {
         this.showTooltip();
      }
   }
}
