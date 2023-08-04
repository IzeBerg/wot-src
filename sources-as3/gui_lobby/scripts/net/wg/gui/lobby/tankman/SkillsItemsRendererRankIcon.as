package net.wg.gui.lobby.tankman
{
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class SkillsItemsRendererRankIcon extends UIComponentEx
   {
       
      
      public var iconRank:UILoaderAlt;
      
      private var imageUrl:String;
      
      private var isEnabled:Boolean = true;
      
      private const UPDATE_DATA:String = "updateData";
      
      public function SkillsItemsRendererRankIcon()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.iconRank.dispose();
         super.onDispose();
      }
      
      public function setData(param1:String, param2:*) : void
      {
         this.imageUrl = param1;
         this.isEnabled = param2;
         invalidate(this.UPDATE_DATA);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(this.UPDATE_DATA))
         {
            if(this.imageUrl)
            {
               this.iconRank.source = this.imageUrl;
            }
            if(enabled != this.isEnabled)
            {
               enabled = this.isEnabled;
            }
         }
      }
   }
}
