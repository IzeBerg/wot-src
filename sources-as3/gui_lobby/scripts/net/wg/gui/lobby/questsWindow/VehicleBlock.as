package net.wg.gui.lobby.questsWindow
{
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.questsWindow.components.QuestsDashlineItem;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class VehicleBlock extends UIComponentEx
   {
      
      private static const DEFAULT_WIDTH:int = 205;
       
      
      public var nationIcon:UILoaderAlt;
      
      public var typeIcon:UILoaderAlt;
      
      public var levelMC:MovieClip;
      
      public var tankSmallIcon:UILoaderAlt;
      
      public var discountDL:QuestsDashlineItem;
      
      private var nations:Array;
      
      public var data:Object = null;
      
      public function VehicleBlock()
      {
         this.nations = [];
         super();
         this.levelMC.visible = false;
         this.nations = App.utils.getNationNamesS();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.discountDL.width = DEFAULT_WIDTH;
         this.nationIcon.hideLoader = false;
         this.typeIcon.hideLoader = false;
         this.tankSmallIcon.hideLoader = false;
      }
      
      public function setData(param1:Object) : void
      {
         this.data = param1;
         invalidateData();
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         if(isInvalid(InvalidationType.DATA) && this.data)
         {
            _loc1_ = this.getNationIconPath(this.data.nationID);
            _loc2_ = this.getTypeIconPath(this.data.vType);
            if(this.nationIcon.source != _loc1_)
            {
               this.nationIcon.source = _loc1_;
            }
            if(this.typeIcon.source != _loc2_)
            {
               this.typeIcon.source = _loc2_;
            }
            if(this.tankSmallIcon.source != this.data.vIconSmall)
            {
               this.tankSmallIcon.source = this.data.vIconSmall;
            }
            this.discountDL.label = this.data.vName;
            this.discountDL.value = this.data.discount;
            this.levelMC.gotoAndStop(this.data.vLevel);
            this.levelMC.visible = true;
         }
      }
      
      public function getNationIconPath(param1:int) : String
      {
         return "../maps/icons/filters/nations/" + this.nations[param1] + ".png";
      }
      
      public function getTypeIconPath(param1:String) : String
      {
         return "../maps/icons/filters/tanks/" + param1 + ".png";
      }
      
      override protected function onDispose() : void
      {
         if(this.nationIcon)
         {
            this.nationIcon.dispose();
            removeChild(this.nationIcon);
            this.nationIcon = null;
         }
         if(this.typeIcon)
         {
            this.typeIcon.dispose();
            removeChild(this.typeIcon);
            this.typeIcon = null;
         }
         removeChild(this.levelMC);
         this.levelMC = null;
         if(this.tankSmallIcon)
         {
            this.tankSmallIcon.dispose();
            removeChild(this.tankSmallIcon);
            this.tankSmallIcon = null;
         }
         if(this.nations)
         {
            this.nations.splice(0,this.nations.length);
            this.nations = null;
         }
         if(this.discountDL)
         {
            this.discountDL.dispose();
            removeChild(this.discountDL);
            this.discountDL = null;
         }
         this.data = null;
         super.onDispose();
      }
   }
}
