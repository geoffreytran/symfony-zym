<?php

use Zym\HttpKernel\Kernel;
use Symfony\Component\Config\Loader\LoaderInterface;

class AppKernel extends Kernel
{
    public function registerBundles()
    {
        $bundles = array(
            new Symfony\Bundle\FrameworkBundle\FrameworkBundle(),
            new Symfony\Bundle\SecurityBundle\SecurityBundle(),
            new Symfony\Bundle\TwigBundle\TwigBundle(),
            new Symfony\Bundle\MonologBundle\MonologBundle(),
            new Symfony\Bundle\SwiftmailerBundle\SwiftmailerBundle(),
            new Symfony\Bundle\AsseticBundle\AsseticBundle(),
            new Doctrine\Bundle\DoctrineBundle\DoctrineBundle(),
            new Sensio\Bundle\FrameworkExtraBundle\SensioFrameworkExtraBundle(),
            new JMS\AopBundle\JMSAopBundle(),
            new JMS\DiExtraBundle\JMSDiExtraBundle($this),
            new JMS\SecurityExtraBundle\JMSSecurityExtraBundle(),

            // Symfony Extra
            new JMS\SerializerBundle\JMSSerializerBundle($this),

            new FOS\UserBundle\FOSUserBundle(),
            new Stof\DoctrineExtensionsBundle\StofDoctrineExtensionsBundle(),
            new Knp\Bundle\PaginatorBundle\KnpPaginatorBundle(),
            new Knp\Bundle\MenuBundle\KnpMenuBundle(),
            new Knp\Bundle\TimeBundle\KnpTimeBundle(),
            new Mopa\Bundle\BootstrapBundle\MopaBootstrapBundle(),
            new OpenSky\Bundle\RuntimeConfigBundle\OpenSkyRuntimeConfigBundle(),
            new Presta\SitemapBundle\PrestaSitemapBundle(),

            // Zym
            new Zym\Bundle\FrameworkBundle\ZymFrameworkBundle(),
            new Zym\Bundle\DoctrineBundle\ZymDoctrineBundle(),
            new Zym\Bundle\UserBundle\ZymUserBundle(),
            new Zym\Bundle\FieldBundle\ZymFieldBundle(),
            new Zym\Bundle\NodeBundle\ZymNodeBundle(),
            new Zym\Bundle\RouterBundle\ZymRouterBundle(),
            new Zym\Bundle\SecurityBundle\ZymSecurityBundle(),
            new Zym\Bundle\TaxonomyBundle\ZymTaxonomyBundle(),
            new Zym\Bundle\SessionBundle\ZymSessionBundle(),
            new Zym\Bundle\MenuBundle\ZymMenuBundle(),
            new Zym\Bundle\RuntimeConfigBundle\ZymRuntimeConfigBundle(),
            new Zym\Bundle\ThemeBundle\ZymThemeBundle(),
            new Zym\Bundle\SearchBundle\ZymSearchBundle(),
            new Zym\Bundle\SearchElasticaBundle\ZymSearchElasticaBundle(),
        );

        if (in_array($this->getEnvironment(), $this->debugEnvironments)) {
            $bundles[] = new Acme\DemoBundle\AcmeDemoBundle();
            $bundles[] = new Symfony\Bundle\WebProfilerBundle\WebProfilerBundle();
            $bundles[] = new Sensio\Bundle\DistributionBundle\SensioDistributionBundle();
            $bundles[] = new Sensio\Bundle\GeneratorBundle\SensioGeneratorBundle();

            $bundles[] = new Doctrine\Bundle\MigrationsBundle\DoctrineMigrationsBundle();
            $bundles[] = new Doctrine\Bundle\FixturesBundle\DoctrineFixturesBundle();
        }

        return $bundles;
    }

    public function registerContainerConfiguration(LoaderInterface $loader)
    {
        $loader->load(__DIR__.'/config/config_'.$this->getEnvironment().'.yml');
    }
}
