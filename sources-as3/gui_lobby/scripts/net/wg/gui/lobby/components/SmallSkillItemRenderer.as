package net.wg.gui.lobby.components
{
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.components.data.SkillsVO;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.ListItemRenderer;
   
   public class SmallSkillItemRenderer extends ListItemRenderer
   {
      
      private static const BUY_ALPHA:Number = 0.35;
       
      
      public var loader:UILoaderAlt;
      
      public var newSkillMc:MovieClip;
      
      private var _skillData:SkillsVO = null;
      
      public function SmallSkillItemRenderer()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         this.data = param1;
         this._skillData = SkillsVO(param1);
         if(this._skillData != null)
         {
            invalidateData();
         }
      }
      
      override public function toString() : String
      {
         return "[Scaleform SmallSkillItemRenderer " + name + "]";
      }
      
      override protected function configUI() : void
      {
         super.configUI();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA) && this._skillData)
         {
            this.loader.visible = StringUtils.isNotEmpty(this._skillData.icon);
            if(this.loader.visible)
            {
               this.loader.source = this._skillData.icon;
            }
            if(this._skillData.buy)
            {
               this.loader.visible = false;
               if(this.newSkillMc != null)
               {
                  this.newSkillMc.visible = true;
                  if(this._skillData.showBuyAnimation)
                  {
                     this.newSkillMc.gotoAndPlay(1);
                  }
                  else
                  {
                     this.newSkillMc.gotoAndStop(1);
                  }
               }
            }
            else
            {
               if(this.newSkillMc != null)
               {
                  this.newSkillMc.visible = false;
               }
               this.loader.alpha = this._skillData.active || this._skillData.buy ? Number(1) : Number(BUY_ALPHA);
            }
         }
      }
      
      override protected function onDispose() : void
      {
         if(this.loader != null)
         {
            this.loader.dispose();
            this.loader = null;
         }
         this._skillData = null;
         this.newSkillMc = null;
         super.onDispose();
      }
   }
}
