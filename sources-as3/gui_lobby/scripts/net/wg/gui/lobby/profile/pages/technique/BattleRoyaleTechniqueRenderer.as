package net.wg.gui.lobby.profile.pages.technique
{
   import flash.text.TextField;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.lobby.profile.pages.technique.data.TechniqueListVehicleVO;
   import scaleform.clik.constants.InvalidationType;
   
   public class BattleRoyaleTechniqueRenderer extends SoundListItemRenderer
   {
       
      
      public var vehicleTF:TextField = null;
      
      public var battlesTF:TextField = null;
      
      public var winsTF:TextField = null;
      
      public var avgExpTF:TextField = null;
      
      public var avgDamTF:TextField = null;
      
      public var avgFragsTF:TextField = null;
      
      public var nationIcon:Image = null;
      
      public var typeIcon:Image = null;
      
      public var tankIcon:Image = null;
      
      public function BattleRoyaleTechniqueRenderer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.visible = false;
         this.buttonMode = true;
         this.mouseChildren = false;
      }
      
      override protected function draw() : void
      {
         var _loc1_:TechniqueListVehicleVO = null;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            _loc1_ = data as TechniqueListVehicleVO;
            if(_loc1_ != null)
            {
               this.visible = true;
               this.nationIcon.source = _loc1_.nationIconPath;
               this.typeIcon.source = _loc1_.typeIconPath;
               this.tankIcon.source = _loc1_.tankIconPath;
               this.vehicleTF.text = _loc1_.shortUserName;
               this.battlesTF.text = _loc1_.battlesCount.toString();
               this.winsTF.text = _loc1_.winsCount.toString();
               this.avgExpTF.text = _loc1_.avgExperience.toFixed();
               this.avgDamTF.text = _loc1_.avgDamage.toFixed();
               this.avgFragsTF.text = _loc1_.avgFrags.toFixed();
            }
            else
            {
               this.visible = false;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.nationIcon.dispose();
         this.nationIcon = null;
         this.typeIcon.dispose();
         this.typeIcon = null;
         this.tankIcon.dispose();
         this.tankIcon = null;
         this.vehicleTF = null;
         this.battlesTF = null;
         this.winsTF = null;
         this.avgExpTF = null;
         this.avgDamTF = null;
         this.avgFragsTF = null;
         super.onDispose();
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         invalidateData();
      }
   }
}
